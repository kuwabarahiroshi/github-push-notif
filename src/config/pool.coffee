#
# Used as express middleware
#
module.exports = (req, res, next) ->
  req.app.locals
    nextcore:
      scheme: 'http'
      host:   'nextcore-pool.homes.co.jp'
      port:   80
      #key:    'sample-key'
      #secret: 'MzkyZmRkNmJjN2E1M2NhYjIzNTcxMTY3Y2ZhMGJiNDRmNDc3YWIzYzk1YjgzNzIwMmY1YzRiOWE5OTIzNmE0YQ'
      key:    'YzQxODRmOGFlODZhYjVhZTg0N2NjZjMz'
      secret: 'NTNhM2VkYzkwNGQ3NWRjNzM3ZDRkYjg1OWM0MTZjZTE5YmY4ZWNlMzVlNjBmZmViMThkOTlhZTJjNTE3NzA1Mw'

  next()
