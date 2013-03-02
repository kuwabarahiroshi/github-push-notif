{ GET, POST, PUT, DELETE, ALL } = require 'app/lib/router/verbs'

module.exports =
  'app.index':
    route: GET '/', 'index'

  'app.index.paging':
    route: GET '/:page', 'index'
