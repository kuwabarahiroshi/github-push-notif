{ GET, POST, PUT, DELETE, ALL, SOCKET } = require 'app/lib/router/verbs'

module.exports =
  'index':
    route: GET '/', 'index'
  'api.explorer':
    route: GET /^\/(GET|POST|PUT|DELETE)(\/.*)/, 'index'
  'api.proxy':
    route: ALL '/proxy/*', 'proxy'
