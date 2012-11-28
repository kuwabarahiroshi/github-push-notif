path = require 'path'

router = (method) ->
  (pattern, action_path) ->
    method: method
    pattern: pattern
    action: require path.join '../controllers', action_path

exports.verbs =
  ['GET', 'POST', 'PUT', 'DELETE', 'ALL'].map router
