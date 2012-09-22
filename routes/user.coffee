User = require '../models/users'

module.exports = (app) ->
  app.post '/user/:userId', (req, res) ->
    console.log 'here', req.params, req.body
    if req.user
      res.send 403, 'Forbidden access' unless req.params.userId == req.user._id
    else
      res.send 401, 'Log in to perform this action'
    User.update req.params.userId, req.body, (err, user) ->
      if err
        res.send 500, err
      else
        res.send 200
