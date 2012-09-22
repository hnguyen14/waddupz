Post = require '../models/post'

module.exports = (app) ->
  app.post '/post', (req, res) ->
    keywords = req.body.keywords.split(',')
    req.body.keywords = keywords
    Post.create req.body, (err, post) ->
      if err
        res.send 500, err
      else
        res.send 200, post
