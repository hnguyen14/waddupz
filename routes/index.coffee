module.exports = (app) ->

  require('./authenticate')(app)

  app.get '/', (req, res) ->
    res.render 'index', title: 'Express'
