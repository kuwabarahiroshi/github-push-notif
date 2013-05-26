config = require 'app/config'
Redis = require 'redis'
URL = require 'url'

{ hostname, port, auth, pathname } = URL.parse(config.redis)

redis = Redis.createClient(port, hostname, no_ready_check: true)
redis.auth(auth.split(':').pop()) if auth
redis.select(db) if pathname and (db = pathname.split('/').pop())

redis.on 'ready', ->
  redis.is_ready = yes

redis.on 'end', ->
  redis.is_ready = no

redis.on 'error', console.error

module.exports = redis
