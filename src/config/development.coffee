#
# Used as express middleware
#
module.exports = (req, res, next) ->
  req.app.locals
    nextcore:
      scheme: 'http'
      host:   'nextcore-unit-kuwabara.homes.co.jp'
      port:   80
      key:    'sample-key'
      secret: 'MzkyZmRkNmJjN2E1M2NhYjIzNTcxMTY3Y2ZhMGJiNDRmNDc3YWIzYzk1YjgzNzIwMmY1YzRiOWE5OTIzNmE0YQ'

  next()
