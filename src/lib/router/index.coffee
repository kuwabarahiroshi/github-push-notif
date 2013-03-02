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
# @example
#   routing = require 'app/routing'
#   routing.generate 'index'              # returns '/'
#   routing.generate 'api', '/sample/api' # returns '/api/sample/api'
#
exports.generate = (name, params) ->
  #TODO: implement
  name
