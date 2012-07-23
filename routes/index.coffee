module.exports = (app) ->
  require('./authenticate')(app)
  require('./post')(app)

  app.get '/', (req, res) ->
    res.render 'index', title: 'Express'
