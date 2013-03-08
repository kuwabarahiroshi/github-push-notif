#
# Production env config
#
module.exports =
  port: 5005
  logger: 'default'
  secret: 'fNmVpvV7fTQviboauGO67VMksgthy75DSYMH4tla'

  moshimo:
    host: 'api.moshimo.com'
    token: 'Hp1ZWT4LN8VIkzCg8vab2fuO8Al6X'

  redis: process.env.REDISCLOUD_URL
