Query = require 'querystring'
config = require 'app/config'
moshimo = require 'app/lib/moshimo/cli'
search = require 'app/controllers/article/search'

module.exports = (req, res) ->
  { category } = req.params

  moshimo.categories { category }, (err, data)->
    throw err if err
    category = data.Category
    children = data.Category.Children
    parents = data.Category.Parents
    hierarchy = {
      category,
      children,
      parents
    }

    if children.length
      res.render 'index/categories', hierarchy

    else
      res.hierarchy = hierarchy
      req.params.category = category.Code
      search req, res
