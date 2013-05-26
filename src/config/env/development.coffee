{ merge } = require 'app/lib/util'
production = require './production'
current = require './current'

#
# Development env config
#
module.exports = merge {}, current,
  port: production.port + 4
  logger: 'dev'
