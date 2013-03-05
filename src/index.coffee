# Module requirements
express = require 'express'
assets  = require 'connect-assets'
http    = require 'http'
path    = require 'path'
router  = require 'app/lib/router'
page    = require 'app/lib/page'

# Create app
app = express()

# Env vars
env = app.get 'env'
config = require('app/config').freeze env
views_dir = path.join process.cwd(), 'views'
public_dir = path.join process.cwd(), 'public'
port = process.env.PORT or config.port or 5000

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
router.bootstrap app

# Start Server
http.createServer(app).listen port, ->
  console.log "Listening on #{port}\nEnv: #{env}\nPress CTRL-C to stop server."
