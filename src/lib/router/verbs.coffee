Path = require 'path'

action_pointer = (path) ->
  require Path.join 'app/controllers', path

listen = (verb) ->
  (pattern, actions...) ->
    type:   'http'
    method:  verb
    pattern: pattern
    actions: actions.map action_pointer

socket_configurator =
  (message, actions...) ->
    type:    'socket'
    message: message
    actions: actions.map action_pointer

verbs = {}
for verb in ['GET', 'POST', 'PUT', 'DELETE', 'ALL']
  verbs[verb] = listen(verb)

# routing configurator for socket.io
verbs['SOCKET'] = socket_configurator

module.exports = verbs
