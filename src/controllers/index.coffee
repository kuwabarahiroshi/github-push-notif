Query = require 'querystring'
config = require 'app/config'

module.exports = (req, res) ->
  [method, path] = req.params
  query = Query.stringify req.query
  res.render 'index', { config, method, path, query }
