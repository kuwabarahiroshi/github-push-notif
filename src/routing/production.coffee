[GET, POST, PUT, DELETE, ALL] = require('app/routing/verbs')

module.exports =
  index: GET '/',      'index'
  api:   ALL '/api/*', 'api'
