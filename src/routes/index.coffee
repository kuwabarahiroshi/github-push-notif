# Module requirements
path = require 'path'

# Default action
do_nothing = (req, res) -> res.end()

exports.bootstrap = (app) ->
  # Get routing entries for app env
  entries = require path.join __dirname, app.get 'env'

  for name, config of entries
    do (name, config) ->
      method  = config.method?.toLowerCase() or 'get'
      pattern = config.pattern
      action  = config.action or do_nothing

      # Register routing config
      app[method] pattern, action

exports.generate = (name, params) ->
  name
