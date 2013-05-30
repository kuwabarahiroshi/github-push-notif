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
  payload = JSON.stringify(req.body)

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

    for channelId of registry
      query = JSON.stringify {
        channelId: channelId
        subchannelId: '0'
        payload: 'payload'
      }
      console.log channelId
      console.log query
      message = https.request(request, messageHandler)
      message.write(query)
      message.end()

  tokenHandler
