{ merge } = require 'app/lib/util'
production = require './production'
pool = require './pool'

#
# Backstage env config
#
module.exports = merge {}, pool,
  port: production.port + 2
