# Module requirements
express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
http = require 'http'
path = require 'path'
routes = require './routes'

# Create app
app = express()

# Env vars
port = process.env.PORT or process.env.VMC_APP_PORT or 3000
env = app.get 'env'
app_dir = path.join process.cwd(), 'app'
views_dir = path.join process.cwd(), 'views'
public_dir = path.join process.cwd(), 'public'
config = require path.join app_dir, 'config', env

# Configure
app.configure ->
  app.set 'port', port
  app.set 'views', views_dir
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser 'c1a36caa10c91e1bd2eed400d5a8717eea649573'
  app.use express.session()
  app.use express.static public_dir
  app.use config
  app.use app.router
  app.use assets()

# Dev config
app.configure 'development', ->
  app.use express.errorHandler()

# Routing
routes.bootstrap app

# Start Server
http.createServer(app).listen port, ->
  console.log "Listening on #{port}\nEnv: #{env}\nPress CTRL-C to stop server."
