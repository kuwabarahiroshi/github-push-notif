Path = require 'path'
Client = require 'nextcore/client'
Query = require 'querystring'

merge = (borrower, providers...) ->
  for p in providers
    borrower[key] = value for own key, value of p
  borrower

module.exports = (req, res) ->
  config  = req.app.locals.nextcore
  method  = req.method
  path    = Path.join '/', req.params[0]
  query   = merge {}, req.query, req.body
  headers = req.headers

  client = new Client config
  client.on 'response', (api_response) ->
    api_response.on 'data', (chunk) -> res.write chunk
    api_response.on 'end', -> res.end()

  client.on 'error', (err) ->

  client.request method, path, query, headers
