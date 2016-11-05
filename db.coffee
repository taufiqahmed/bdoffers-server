Datastore = require 'nedb'

db = {}
db.offer = new Datastore {filename: './offers.db', autoload: true}

module.exports = db