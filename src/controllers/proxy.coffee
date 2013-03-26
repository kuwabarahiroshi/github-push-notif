Path = require 'path'
Query = require 'querystring'
Client = require 'app/lib/nextcore/client'
config = require 'app/config'
{ merge } = require 'app/lib/util'

module.exports = (req, res) ->
  path    = Path.join '/', req.params[0]
  query   = merge {}, req.query, req.body
  method  = query['http-request-method'] || req.method
  headers = req.headers
  delete query['http-request-method']

  if method is 'PUT'
    headers['content-type'] = 'application/x-www-form-urlencoded'

  client = new Client config.nextcore
  client.on 'response', (api_response) ->
    api_response.on 'data', (chunk) -> res.write chunk
    api_response.on 'end', -> res.end()

  client.on 'error', (err) ->
    console.error err
    res.write err.toString()
    res.end()

  client.request method, path, query, headers
