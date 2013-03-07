{ merge } = require 'app/lib/util'
backstage = require './backstage'

#
# Current env config
#
module.exports = merge {}, backstage,
  port: 5001
  logger: 'dev'
