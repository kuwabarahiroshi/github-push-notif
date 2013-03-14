# Module requirements
config = require 'app/config'

# Default action
do_nothing = (req, res) -> res.end()

# @API
# @function bootstrap
# @param app Express app
#
exports.bootstrap = (app, socket) ->
  # Get routing entries for app env
  entries = require "app/config/routing/#{config.env}"

  # Export entries as module constant.
  Object.freeze entries
  Object.defineProperty exports, 'ENTRIES',
    value: entries
    enumerable: yes
    writable: no
    configurable: no

  # Register each entries as app route.
  for id, config of entries
    do (id, config) ->
      {type, method, pattern, message, actions} = config.route
      method  = method?.toLowerCase() or 'get'
      actions ||= [do_nothing]
      if type == 'http'
        app[method] pattern, (req, res)->
          req.route.id = id
          action(req, res) for action in actions

      if type == 'socket'
        socket.on message, (client)->
          client.message = message
          action(client, socket) for action in actions

# @API
# @function generate
# @param name Route name
# @param params Route parameters
#
path = (name, params) ->
  unless name of exports.ENTRIES
    throw new Error("'#{name}' route is not defined")

  { route } = exports.ENTRIES[name]

  unless route
    throw new Error("'#{name}' route is miss configured.")

  unless route.pattern
    return ''

  unless 'string' == typeof route.pattern
    return ''

  route.pattern.replace(/\\?:([a-zA-Z][\w]*)/g, (match, name)->
    return match.slice(1) if match.charAt(0) == '\\'
    return params[name] if name of params
    ''
  )

exports.generator = ->
  (req, res, next)->
    req.app.locals.path = path
    next()
