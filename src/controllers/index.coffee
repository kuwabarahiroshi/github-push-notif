Query = require 'querystring'

module.exports = (req, res) ->
  [method, path] = req.params
  query = Query.stringify req.query
  res.render 'index', { method, path, query }
