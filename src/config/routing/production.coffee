{ GET, POST, PUT, DELETE, ALL, SOCKET } = require 'app/lib/router/verbs'

module.exports =
  'app.index':
    route: GET '/', 'index'

  'app.categories':
    route: GET '/categories', 'index'

  'app.category.detail':
    route: GET '/categories/:category', 'index'

  'app.article.search':
    route: GET '/articles', 'article/search'

  'app.article.detail':
    route: GET '/articles/:article_id', 'article/detail'

  'socket.connection':
    route: SOCKET 'connection', 'socket/connection'
