Path = require 'path'
{ deepFreeze } = require 'app/lib/util'

module.exports =
  freeze: (env) ->
    unless Object.isFrozen @
      env ||= 'development'
      config = require "app/config/env/#{Path.basename(env)}"
      @[key] = val for key, val of config
      @env = env
      delete @freeze
      deepFreeze @

    # return self
    @
