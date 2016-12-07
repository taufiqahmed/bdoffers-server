Datastore = require 'nedb'

db = {}
db.offer = new Datastore {filename: './data/offers.db', autoload: true}

module.exports = db