module.exports = (app) ->
  require('./authenticate')(app)
  require('./post')(app)
  require('./user')(app)

  app.get '/', (req, res) ->
    res.render 'index', title: 'Express'

  app.get '/test', (req, res) ->
    res.render 'test', title: 'TESTING PAGE'
