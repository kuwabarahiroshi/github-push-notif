# Module requirements
express = require 'express'
stylus  = require 'stylus'
assets  = require 'connect-assets'
http    = require 'http'
path    = require 'path'
router  = require 'app/lib/router'

# Create app
app = express()

# Env vars
env = app.get 'env'
config = require('app/config').freeze env
views_dir = path.join process.cwd(), 'views'
public_dir = path.join process.cwd(), 'public'
port = process.env.PORT or process.env.VMC_APP_PORT or config.server?.port or 3000

# Configure
app.configure ->
  app.set 'port', port
  app.set 'views', views_dir
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger(config.logger or 'dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(config.secret)
  app.use express.session()
  app.use express.static(public_dir)
  app.use app.router
  app.use assets()

# Dev config
app.configure 'development', ->
  app.use express.errorHandler()

# Routing
router.bootstrap app

# Start Server
http.createServer(app).listen port, ->
  console.log "Listening on #{port}\nEnv: #{env}\nPress CTRL-C to stop server."
