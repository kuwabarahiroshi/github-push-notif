registry = require 'app/lib/registry'
https = require 'https'
Query = require 'querystring'
config = require 'app/config'
StreamBuffer = require 'app/lib/util/stream_buffer'
{ merge } = require 'app/lib/util'

#
#
#
module.exports = (req, res) ->
  res.end()
  try
    payload = JSON.parse(req.body?.payload)
  catch e
    console.error e

  return unless payload

  query =
    client_id: config.google.clientId
    client_secret: config.google.clientSecret
    refresh_token: config.google.refreshToken
    grant_type: 'refresh_token'

  tokenReq = https.request(config.google.api.token, handler(payload))
  tokenReq.write(Query.stringify(query))
  tokenReq.end()

handler = (payload) ->
  tokenHandler = (res) ->
    buffer = new StreamBuffer
    res.pipe buffer
    res.on 'end', ->
      sendMessage JSON.parse buffer

  messageHandler = (res) ->
    buffer = new StreamBuffer
    res.pipe buffer
    res.on 'end', ->
      console.log buffer.toString()

  sendMessage = (auth) ->
    request = merge {}, config.google.api.message
    request.headers =
      'Content-Type': 'application/json'
      'Authorization': auth.token_type + ' ' + auth.access_token

    url = payload.repository?.url
    hash = payload.head_commit?.id || url
    pusher = payload.pusher?.name || 'unknown'
    commits = payload.commits?.length || 0
    at = payload.repository?.pushed_at || Date.now()

    if url of registry
      for channelId, channelConfig of registry[url]
        query = JSON.stringify {
          channelId: channelId
          subchannelId: '0'
          payload: JSON.stringify({url, hash, at, pusher, commits})
        }
        console.log query
        message = https.request(request, messageHandler)
        message.write(query)
        message.end()

  tokenHandler
