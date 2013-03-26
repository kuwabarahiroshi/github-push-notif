Path = require 'path'
{ deepFreeze } = require 'app/lib/util'

# Module itself is a function which returns an express middleware.
config = ->
  (req, res, next)->
    req.app.locals({ config })
    next()

# Freeze config with a specific environment.
#
# @param {String} env
# @return config
config.freeze = (env) ->
  unless Object.isFrozen(this)
    env ||= 'development'
    config = require "app/config/env/#{Path.basename(env)}"
    @[key] = val for key, val of config
    @env = env
    delete @freeze
    deepFreeze this

  return this

module.exports = config
