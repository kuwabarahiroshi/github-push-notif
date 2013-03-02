{ merge } = require 'app/lib/util'
current = require './current'

#
# Development env config
#
module.exports = merge {}, current,
  port: 5000
  logger: 'dev'
