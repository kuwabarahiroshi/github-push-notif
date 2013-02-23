{ GET, POST, PUT, DELETE, ALL } = require 'app/lib/router/verbs'

module.exports =
  index:  GET '/',                             'index'
  client: GET /\/(GET|POST|PUT|DELETE)(\/.*)/, 'index'
  api:    ALL '/api/*',                        'api'
