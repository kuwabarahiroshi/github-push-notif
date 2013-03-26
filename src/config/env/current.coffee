{ merge } = require 'app/lib/util'
production = require './production'
backstage = require './backstage'

#
# Current env config
#
module.exports = merge {}, backstage,
  port: production.port + 3
  logger: 'dev'

  nextcore:
    scheme: 'http'
    host:   'nextcore-test.homes.co.jp'
    port:   80
    key:    'sample-key'
    secret: 'MzkyZmRkNmJjN2E1M2NhYjIzNTcxMTY3Y2ZhMGJiNDRmNDc3YWIzYzk1YjgzNzIwMmY1YzRiOWE5OTIzNmE0YQ'
