registry = require 'app/lib/registry'

module.exports = (req, res) ->
  try
    request = JSON.parse(req.body?.request)
  catch e
    console.error e
    return res.end()

  { channelId, subscribe, unsubscribe } = request

  if subscribe
    for repository in subscribe
      unless repository of registry
        registry[repository] = {}

      unless channelId of registry[repository]
        registry[repository][channelId] = {}

  if unsubscribe
    for repository in unsubscribe
      if (repository of registry) and (channelId of registry[repository])
        delete registry[repository][channelId]

  console.log registry

  res.end()
