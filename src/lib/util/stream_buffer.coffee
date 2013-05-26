stream = require 'stream'

class StreamBuffer extends stream.Stream
  constructor: (@encoding)->
    @encoding ||= 'utf8'
    @writable = yes
    @buffers = []
    super()

  write: (data)->
    @buffers.push data if Buffer.isBuffer data

  end: (data)->
    @buffers.push data if Buffer.isBuffer data

  toString: (encoding)->
    Buffer.concat(@buffers).toString(encoding or @encoding)

module.exports = StreamBuffer
