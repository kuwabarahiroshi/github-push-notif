{ GET, POST, PUT, DELETE, ALL } = require 'app/lib/router/verbs'

module.exports =
  'app.categories':
    route: GET '/', 'index'

  'app.sub.categories':
    route: GET '/categories/:category/subcategories', 'index'

  'app.subsub.categories':
    route: GET '/categories/:category/subcategories/:subcategory', 'index'
