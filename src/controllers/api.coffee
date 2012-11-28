http = require 'http'
querystring = require 'querystring'
Path = require 'path'
urlsafe_base64 = require('text').urlsafeEncode64

module.exports = (req, res) ->
  host = req.app.locals.nextcore.host
  path = Path.join '/', req.params[0]
  method = req.method
  query = querystring.stringify req.query
  console.log method, host, path, query
  res.render 'proxy'
