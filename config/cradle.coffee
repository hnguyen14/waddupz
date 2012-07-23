cradle = require 'cradle'
view = require '../couchdb/view'
url = require 'url'

database = process.env.DATABASE || 'waddupz'
database += "_#{process.env.ENV}" unless process.env.ENV == 'production'

cloudantUrl = process.env.CLOUDANT_URL || "http://localhost:5984/#{database}"
cloudant = url.parse cloudantUrl
options = {}
options.host = "#{cloudant.protocol}//#{cloudant.hostname}"
options.port = cloudant.port || if 'https:' == cloudant.protocol then 443 else 80
if cloudant.auth
  options.auth =
    username: cloudant.auth.split(':')[0]
    password: cloudant.auth.split(':')[1]

server = new (cradle.Connection)(options)

db = server.database database
view db

module.exports = db
