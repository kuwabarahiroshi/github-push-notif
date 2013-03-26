{ merge } = require 'app/lib/util'
production = require './production'

#
# Pool env config
#
module.exports = merge {}, production,
  port: production.port + 1

  nextcore:
    scheme: 'http'
    host:   'nextcore-pool.homes.co.jp'
    port:   80
    key:    'YzQxODRmOGFlODZhYjVhZTg0N2NjZjMz'
    secret: 'NTNhM2VkYzkwNGQ3NWRjNzM3ZDRkYjg1OWM0MTZjZTE5YmY4ZWNlMzVlNjBmZmViMThkOTlhZTJjNTE3NzA1Mw'
