db = require '../db.coffee'

exports.register = (server, options, next)->
  server.route {
    method: 'POST'
    path: '/offers/'
    handler: (request, reply)->
      doc = request.payload
      doc.collection = 'offers'
      db.offer.insert doc, (err, newDoc)=>
        if newDoc
          return reply {id:newDoc._id, collection:newDoc.collection}
        else
          return reply err
  }
  next()

exports.register.attributes = {
  name: 'AddOffer'
  version: '1.0.0'
}