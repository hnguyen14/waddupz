Post = require '../models/post'

module.exports = (app) ->
  app.post '/post', (req, res) ->
    keywords = req.body.keywords.split(',')
    req.body.keywords = keywords
    Post.create req.body, (err, post) ->
      res.render 'index', title: post.title
