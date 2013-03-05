Query = require 'querystring'
config = require 'app/config'
moshimo = require 'app/lib/moshimo/cli'

module.exports = (req, res) ->
  {category, subcategory} = req.params
  console.log "category: #{category}, subcategory: #{subcategory}"

  unless category
    return moshimo.categories (err, categories)->
      throw err if err
      res.render 'index/categories', { categories }

  unless subcategory
    return moshimo.subcategories { category }, (err, categories)->
      throw err if err
      res.render 'index/subcategories', { categories }
