db = require '../config/cradle'

User = module.exports =
  findById: (id, cb) ->
    db.get id, (err, user) ->
      return err if err
      cb null, user

  findOrCreate: (profile, cb) ->
    User.findByFacebookId profile.id, (err, user) ->
      return cb err if err
      if user
        if profile
          user.authHash = profile
        user.updatedAt = new Date()
        db.save user, (err, res) ->
          return cb err if err
          user._rev = res.rev
          cb null, user
      else
        doc =
          type: 'User'
          authHash: profile
          createdAt: new Date()
          updatedAt: new Date()
        db.save doc, (err, doc) ->
          return cb err if err
          doc._id = doc.id
          doc._rev = doc.rev
          cb null, doc

  findByFacebookId: (facebookId, cb) ->
    db.view 'User/by_facebook_id', {startkey: facebookId, include_docs: true}, (err, res) ->
      return cb err if err
      cb null, res[0]?.doc

  update: (userId, data, cb) ->
    db.get userId, (err, user) ->
      return cb err if err
      if data.keyword
        user.keywords or= []
        user.keywords.push data.keyword if user.keywords.indexOf(data.keyword) < 0

      db.save user, cb
