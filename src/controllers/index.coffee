querystring = require 'querystring'

module.exports = (req, res) ->
  [method, path] = req.params
  query = querystring.stringify req.query
  res.render 'index',
    method: method,
    path:   path,
    query:  query
