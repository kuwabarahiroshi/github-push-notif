# Module dependencies
EventEmitter = require('events').EventEmitter
Query  = require 'querystring'
Crypto = require 'crypto'
Scheme =
  http:  require 'http'
  https: require 'https'

#
# @module nextcore
# @class Client
#
class Client extends EventEmitter

  # constructor
  #
  # @param config
  #   scheme: Request scheme
  #   host:   API host
  #   port:   API port
  #   key:    Client ID
  #   secret: Client secret
  # @param callback
  #   Callback function which will be invoked on init
  constructor: (config, callback) ->
    @scheme = Scheme[config.scheme]
    @host   = config.host
    @port   = if config.scheme is 'https' then 443 else config.port or 80
    @key    = config.key
    @secret = config.secret
    callback.apply @ if typeof callback is 'function'

  #
  #
  #
  request: (method, path, query, headers) ->
    delete headers.host
    method = method.toUpperCase()
    signed_query = Query.stringify @sign(method, path, query)

    if method in ['GET', 'DELETE']
      path = [path, signed_query].join '?'
      signed_query = ''

    headers['content-length'] = signed_query.length

    request_params =
      hostname: @host
      port: @port
      method: method
      path: path
      headers: headers
      agent: false

    console.log @host + path
    console.log signed_query

    try
      req = @scheme.request request_params
      req.on 'response', (-> @emit 'response', arguments...).bind @
      req.on 'error',    (-> @emit 'error',    arguments...).bind @
      req.write signed_query if signed_query
      req.end()
    catch err
      @emit 'error', err

    @

  #
  #
  #
  sign: (method, path, query) ->
    query.timestamp = Date.now() / 1000 | 0 # timestamp in sec
    query.api_key   = @key
    query.api_sig   = @signiture method, path, query
    query

  #
  #
  #
  signiture: (method, path, query) ->
    q = {}

    # parameter keys should be in alphabetical order
    for key in Object.keys(query).sort()
      q[key] = query[key]

    querystring = Query.stringify q
    unsigned = [method, @host, path, querystring].join "\n"

    new Buffer(
      Crypto
        .createHmac('SHA256', @secret)
        .update(unsigned)
        .digest('hex')
    )
    .toString('base64')
    .replace /[\+\/=]/g, (c) -> {'+': '-', '/': '_', '=': ''}[c]

module.exports = Client
