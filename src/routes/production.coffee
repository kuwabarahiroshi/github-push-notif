[GET, POST, PUT, DELETE, ALL] = require('./util').verbs

module.exports =
  index: GET '/',      'index'
  api:   ALL '/api/*', 'api'
