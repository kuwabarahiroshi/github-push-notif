Query = require 'querystring'
config = require 'app/config'
moshimo = require 'app/lib/moshimo/cli'

module.exports = (req, res) ->
  moshimo.categories (err, categories)->
    throw err if err
    console.log categories
    res.render 'index', { categories }
