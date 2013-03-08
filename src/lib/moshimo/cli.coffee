http = require 'http'
URL = require 'url'
Query = require 'querystring'
StreamBuffer = require 'app/lib/util/stream_buffer'
config = require 'app/config'
cache = require 'app/lib/cache'
{ merge } = require 'app/lib/util'
host = config.moshimo.host

module.exports =
  categories: (opts, cb)->
    q = { article_category_code: opts.category }
    @api '/category/list2', q, (err, data)->
      cb err, data.CategoryList2

  api: (path, option, cb)->
    # try to get cache
    cache.get @key(path, option), (err, json)=>
      throw err if err

      try
        data = JSON.parse json

      return cb(null, data) if data
      return @_api path, option, cb

  key: (path, option)->
    "#{path}?#{Query.stringify option}"

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
          cache.set key, json
          cb null, JSON.parse json
    )
    .on('error', (error)->
      cb error
    )
    .end()
