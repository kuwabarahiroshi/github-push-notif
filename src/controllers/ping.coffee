module.exports = (req, res) ->
  # Create ping-pong response from received data
  data =
    method: req.method
    url: req.url
    query: req.query
    body: req.body
    params: req.params
    cookies: req.cookies
    route: req.route

  # Send response object as JSON
  res.send data
  console.log data
