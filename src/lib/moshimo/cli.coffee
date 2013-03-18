#
# Module dependencies
#
http = require 'http'
URL = require 'url'
Query = require 'querystring'
StreamBuffer = require 'app/lib/util/stream_buffer'
config = require 'app/config'
cache = require 'app/lib/cache'
{ merge } = require 'app/lib/util'
host = config.moshimo.host

#
# Module exports
#
module.exports =
  # Alias for /category/list2
  #
  # @param {Object} opts
  # @param {Function} cb
  categories: (opts, cb)->
    q = { article_category_code: opts.category }
    @api '/category/list2', q, (err, data)->
      cb err, data.CategoryList2

  # Alias for /article/search2
  #
  # @param {Object} query
  # @param {Function} cb
  articles: (opts, cb)->
    q =
      article_category_code: opts.category
      require_tag_list: 1

    @api '/article/search2', q, (err, data)->
      cb err, data.ArticleSearch2

  # Executes Moshimo API request unless cached data available
  #
  # @param {String} path
  # @param {Object} option
  # @param {Function} cb
  api: (path, option, cb)->
    unless cache.is_ready
      return @_api path, option, cb

    # try to get cache
    cache.get @key(path, option), (err, json)=>
      throw err if err

      try
        data = JSON.parse json

      return cb(null, data) if data
      return @_api path, option, cb

  # Generates cache key
  #
  # @param {String} path
  # @param {Object} option
  key: (path, option)->
    "#{path}?#{Query.stringify option}"

  # Moshimo API request and stores to cache
  #
  # @param {String} path
  # @param {Object} option
  # @param {Function} cb
  _api: (path, option, cb)->
    params = merge {}, option,
      authorization_code: config.moshimo.token

    query = Query.stringify params

    uri = "http://#{host}#{path}.json?#{query}"
    console.log "#{new Date} moshimo-api-call: #{uri}"

    req = URL.parse uri

    stream = new StreamBuffer

    key = @key path, option

    http.request(
      req, (res)->
        res.pipe stream
        res.on 'end', ->
          json = stream.toString()
          cache.set key, json if cache.is_ready
          cb null, JSON.parse json
    )
    .on('error', (error)->
      cb error
    )
    .end()
