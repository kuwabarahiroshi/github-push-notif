Path = require 'path'

action_pointer = (path) ->
  require Path.join 'app/controllers', path

configurator = (method) ->
  (pattern, action_path...) ->
    method:  method
    pattern: pattern
    action:  action_path.map action_pointer

module.exports =
  ['GET', 'POST', 'PUT', 'DELETE', 'ALL'].map configurator
