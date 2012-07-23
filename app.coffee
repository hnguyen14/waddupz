express = require 'express'
routes = require './routes'

app = module.exports = express.createServer()
params = require 'express-params'
passport = require './config/facebook-passport'

params.extend app

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "your secret here"
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

require('./routes/index')(app)

app.dynamicHelpers
  passport: (req, res) ->
    data = {}
    data.user = req.user?.authHash
    return data

app.listen process.env.PORT || 3000
