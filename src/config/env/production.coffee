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
    clientId: '461738881469-ogussb6k787p13oi4btrjasadi93l02e.apps.googleusercontent.com'
    clientSecret: 'kCGXix7cK5tMsueQpyiZNoou'
    refreshToken: '1/yLlioTEGQtLQbu1SiH17k0D3RaWEs4TRi_X-M6F1WPo'
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
