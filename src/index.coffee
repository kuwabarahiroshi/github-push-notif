# Module requirements
http     = require 'http'
express  = require 'express'
socketio = require 'socket.io'
assets   = require 'connect-assets'
path     = require 'path'
router   = require 'app/lib/router'
page     = require 'app/lib/page'

# Create app
app = express()
server = http.createServer(app)
io = socketio.listen(server)

# Env vars
env = app.get 'env'
config = require('app/config').freeze env
public_dir = path.join process.cwd(), 'public'

# Configure
app.configure ->
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger(config.logger or 'dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(config.secret)
  app.use express.session()
  app.use express.static(public_dir)
  app.use config()
  app.use assets()
  app.use router.generator()
  app.use page.identify()
  app.use app.router

# Dev config
app.configure 'development', ->
  app.locals.pretty = yes
  app.use express.errorHandler()

# Routing
router.bootstrap app, io

# Export application object
module.exports = server
