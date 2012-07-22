express = require 'express'

app = module.exports = express.createServer()
params = require 'express-params'

params.extend app

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser
    uploadDir: process.env.UPLOAD_DIR
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "your secret here"
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

require('./routes/index')(app)

app.listen process.env.PORT || 3000
