Query = require 'querystring'
config = require 'app/config'
moshimo = require 'app/lib/moshimo/cli'

module.exports = (req, res)->
  moshimo.articles {
    category: req.params.category
  }, (err, data)->
    throw err if err
    res.render 'articles/list', {
      total_hits: data.Found
      rows_per_page: data.Rows
      articles: data.Articles
      category: res.hierarchy.category
      parents: res.hierarchy.parents
    }
