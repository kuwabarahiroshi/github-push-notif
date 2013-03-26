{ merge }   = require 'app/lib/util'
production  = require './production'
current     = require './current'
unit_number = 3411 # 内線番号

#
# Development env config
#
module.exports = merge {}, current,
  port: production.port + unit_number
  logger: 'dev'

  nextcore:
    scheme: 'http'
    host:   'nextcore-unit-kuwabara.homes.co.jp'
    port:   80
    key:    'sample-key'
    secret: 'MzkyZmRkNmJjN2E1M2NhYjIzNTcxMTY3Y2ZhMGJiNDRmNDc3YWIzYzk1YjgzNzIwMmY1YzRiOWE5OTIzNmE0YQ'
