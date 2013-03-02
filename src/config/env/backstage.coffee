{ merge } = require 'app/lib/util'
pool = require './pool'

#
# Backstage env config
#
module.exports = merge {}, pool,
  port: 5002
