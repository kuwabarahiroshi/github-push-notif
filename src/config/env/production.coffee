URL = require 'url'
{ merge } = require 'app/lib/util'

#
# Production env config
#
module.exports =
  port: 5000
  logger: 'default'
  secret: 'fNmVpvV7fTQviboauGO67VMksgthy75DSYMH4tla'

  google:
    clientId: '628419494774.apps.googleusercontent.com'
    clientSecret: 'QEIsBlQJyL5vBDn9dj8vcbah'
    refreshToken: '1/pi_-jLQ5P8wBKfDmKopL9WreF_nf4E1evSiJHZaECx8'
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
