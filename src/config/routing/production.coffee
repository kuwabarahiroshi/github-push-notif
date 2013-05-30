{ GET, POST, PUT, DELETE, ALL, SOCKET } = require 'app/lib/router/verbs'

module.exports =
  'app.index':
    route: GET '/', 'index'

  'app.register':
    route: POST '/register', 'register'

  'app.push':
    route: ALL '/push', 'push'

  'ping':
    route: ALL '/ping', 'ping'
