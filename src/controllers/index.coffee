Query = require 'querystring'
config = require 'app/config'
moshimo = require 'app/lib/moshimo/cli'

module.exports = (req, res) ->
  {category} = req.params
  console.log "category: #{category}"

  unless category
    return moshimo.categories (err, data)->
      throw err if err
      category = data.Category
      children = data.Category.Children
      parents = data.Category.Parents
      res.render 'index/categories', {
        category,
        children,
        parents
      }

  moshimo.subcategories { category }, (err, data)->
    throw err if err
    category = data.Category
    children = data.Category.Children
    parents = data.Category.Parents
    res.render 'index/categories', {
      category,
      children,
      parents
    }
