config = require 'app/config'
{ merge } = require 'app/lib/util'
host = config.moshimo.host
http = require 'http'
URL = require 'url'
Query = require 'querystring'
StreamBuffer = require 'app/lib/util/stream_buffer'


module.exports =
  categories: (cb)->
    @api '/category/list2', {}, (err, data)->
      console.log data.CategoryList2
      cb err, data.CategoryList2

  subcategories: (opts, cb)->
    q = { article_category_code: opts.category }
    @api '/category/list2', q, (err, data)->
      console.log data.CategoryList2
      cb err, data.CategoryList2

  api: (path, option, cb)->
    params = merge option,
      authorization_code: config.moshimo.token

    query = Query.stringify params

    uri = "http://#{host}#{path}.json?#{query}"

    req = URL.parse uri

    stream = new StreamBuffer

    http.request(
      req, (res)->
        res.pipe stream
        res.on 'end', ->
          data = JSON.parse stream.toString()
          cb null, data
    )
    .on('error', (error)->
      cb error
    )
    .end()
