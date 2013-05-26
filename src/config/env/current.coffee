{ merge } = require 'app/lib/util'
production = require './production'
backstage = require './backstage'

#
# Current env config
#
module.exports = merge {}, backstage,
  port: production.port + 3
  logger: 'dev'
