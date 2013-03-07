Path = require 'path'
{ deepFreeze } = require 'app/lib/util'

# express middleware
config = ->
  (req, res, next)->
    req.app.locals({ config })
    next()

config.freeze = (env) ->
  unless Object.isFrozen @
    env ||= 'development'
    config = require "app/config/env/#{Path.basename(env)}"
    @[key] = val for key, val of config
    @env = env
    delete @freeze
    deepFreeze @

  # return self
  @

module.exports = config
