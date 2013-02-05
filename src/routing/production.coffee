[GET, POST, PUT, DELETE, ALL] = require('app/routing/verbs')

module.exports =
  index:  GET '/',                             'index'
  client: GET /\/(GET|POST|PUT|DELETE)(\/.*)/, 'index'
  api:    ALL '/api/*',                        'api'
