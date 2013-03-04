config = require 'app/config'
{ merge } = require 'app/lib/util'
host = config.moshimo.host
http = require 'http'
URL = require 'url'
Query = require 'querystring'
StreamBuffer = require 'app/lib/util/stream_buffer'


module.exports =
  categories: (cb)->
    params =
      authorization_code: config.moshimo.token

    query = Query.stringify params

    uri = "http://#{host}/category/list2.json?#{query}"

    req = URL.parse uri

    stream = new StreamBuffer

    http.request(
      req, (res)->
        res.pipe stream
        res.on 'end', ->
          data = JSON.parse stream.toString()
          cb null, data.CategoryList2.Category.Children
    )
    .on('error', (error)->
      cb error
    )
    .end()
