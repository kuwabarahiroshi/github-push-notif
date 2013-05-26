{ GET, POST, PUT, DELETE, ALL, SOCKET } = require 'app/lib/router/verbs'

module.exports =
  'app.index':
    route: GET '/', 'index'

  'ping':
    route: ALL '/ping', 'ping'
