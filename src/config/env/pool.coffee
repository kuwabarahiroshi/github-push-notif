{ merge } = require 'app/lib/util'
production = require './production'

#
# Pool env config
#
module.exports = merge {}, production,
  port: 5004
