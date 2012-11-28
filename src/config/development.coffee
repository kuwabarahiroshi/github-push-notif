#
# Used as express middleware
#
module.exports = (req, res, next) ->
  req.app.locals
    nextcore:
      scheme: 'http'
      host:   'nextcore-test.homes.co.jp'
      port:   80
      key:    'YzQxODRmOGFlODZhYjVhZTg0N2NjZjMz'
      secret: 'NTNhM2VkYzkwNGQ3NWRjNzM3ZDRkYjg1OWM0MTZjZTE5YmY4ZWNlMzVlNjBmZmViMThkOTlhZTJjNTE3NzA1Mw'

  next()
