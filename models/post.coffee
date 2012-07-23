db = require '../config/cradle'

Post = module.exports =
  create: (doc, cb) ->
    doc.type = 'Post'
    doc.createdAt = new Date()

    db.save doc, (err, res) ->
      return cb err if err
      doc._id = res.id
      doc._rev = res._rev
      cb null, doc
