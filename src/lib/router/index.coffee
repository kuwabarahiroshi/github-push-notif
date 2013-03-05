# Module requirements
config = require 'app/config'

# Default action
do_nothing = (req, res) -> res.end()

# @API
# @function bootstrap
# @param app Express app
#
exports.bootstrap = (app) ->
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
      method  = config.route.method?.toLowerCase() or 'get'
      pattern = config.route.pattern
      actions = config.route.actions or [do_nothing]
      app[method] pattern, (req, res)->
        req.route.id = id
        action(req, res) for action in actions

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

  route.pattern.replace(/\\?:([a-zA-Z][\w]*)/g, (match, name)->
    return match.slice(1) if match.charAt(0) == '\\'
    return params[name] if name of params
    ''
  )

exports.generator = ->
  (req, res, next)->
    req.app.locals.path = path
    next()
