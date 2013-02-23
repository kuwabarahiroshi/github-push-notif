Path = require 'path'

action_pointer = (path) ->
  require Path.join 'app/controllers', path

listen = (verb) ->
  (pattern, action_path...) ->
    method:  verb
    pattern: pattern
    action:  action_path.map action_pointer

verbs = {}
for verb in ['GET', 'POST', 'PUT', 'DELETE', 'ALL']
  verbs[verb] = listen(verb)

module.exports = verbs
