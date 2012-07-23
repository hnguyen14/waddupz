async = require 'async'

module.exports = (db, done) ->
  async.parallel [
    (done) ->
      db.save '_design/User'
        by_facebook_id:
          map: (doc) ->
            if doc.type == 'User'
              emit doc.authHash.id, _id: doc._id
      , done
  ], (err, res) ->
    if err
      console.log err
      throw err

