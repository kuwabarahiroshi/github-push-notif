config = require 'app/config'
Redis = require 'redis'
URL = require 'url'

{ hostname, port, auth, pathname } = URL.parse(config.redis)
redis = Redis.createClient(port, hostname, no_ready_check: true)
redis.auth(auth.split(':').pop()) if auth
redis.select(db) if pathname and (db = pathname.split('/').pop())

module.exports = redis
