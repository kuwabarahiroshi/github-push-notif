registry = require 'app/lib/registry'

module.exports = (req, res) ->
  channelId = req.body?.channelId

  unless channelId of registry
    registry[channelId] = {}

  console.log registry

  res.end()
