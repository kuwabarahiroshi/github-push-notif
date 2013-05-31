URL = require 'url'
{ merge } = require 'app/lib/util'

#
# Production env config
#
module.exports =
  port: 5000
  logger: 'default'
  secret: process.env.EXPRESS_SECRET

  google:
    clientId: process.env.GOOGLE_CLIENT_ID
    clientSecret: process.env.GOOGLE_CLIENT_SECRET
    refreshToken: process.env.GOOGLE_REFRESH_TOKEN
    api:
      token:
        hostname: 'accounts.google.com'
        port: 443
        path: '/o/oauth2/token'
        method: 'POST'
        headers:
          'Content-Type': 'application/x-www-form-urlencoded'
      message:
        hostname: 'www.googleapis.com'
        port: 443
        path: '/gcm_for_chrome/v1/messages'
        method: 'POST'
