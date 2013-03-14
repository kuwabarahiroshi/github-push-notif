{ GET, POST, PUT, DELETE, ALL, SOCKET } = require 'app/lib/router/verbs'

module.exports =
  'app.index':
    route: GET '/', 'index'

  'app.categories':
    route: GET '/categories', 'index'

  'app.category.detail':
    route: GET '/categories/:category', 'index'

  'socket.connection':
    route: SOCKET 'connection', 'socket/connection'
