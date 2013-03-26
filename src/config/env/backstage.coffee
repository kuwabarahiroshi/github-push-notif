{ merge } = require 'app/lib/util'
production = require './production'
pool = require './pool'

#
# Backstage env config
#
module.exports = merge {}, pool,
  port: production.port + 2

  nextcore:
    scheme: 'http'
    host:   'nextcore-backstage.homes.co.jp'
    port:   80
    key:    'sample-key'
    secret: 'MzkyZmRkNmJjN2E1M2NhYjIzNTcxMTY3Y2ZhMGJiNDRmNDc3YWIzYzk1YjgzNzIwMmY1YzRiOWE5OTIzNmE0YQ'
