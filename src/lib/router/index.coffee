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
  for name, config of entries
    do (name, config) ->
      method  = config.method?.toLowerCase() or 'get'
      pattern = config.pattern
      action  = config.action or [do_nothing]
      app[method] pattern, action...

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
