db = require '../db.coffee'

exports.register = (server, options, next)->

  route = [
    {
      method: 'GET'
      path: '/offers/'
      handler: (request, reply)->
        db.offer.find {collection:'offers'}, (err, docList)=>
          if docList.length is 0
            return reply err
          else
            reply docList
    }
    {
      method: 'GET'
      path: '/offers/id={id}'
      handler: (request, reply)->
        id = encodeURIComponent request.params.id
        db.offer.findOne {_id:id}, (err, doc)=>
          if doc
            return reply doc
          else
            return reply err
    }
    {
      method: 'GET'
      path: '/offers/brand={brand}'
      handler: (request, reply)->
        brand = encodeURIComponent request.params.brand
        db.offer.find {brand: brand}, (err, docList)=>
          if docList.length is 0
            return reply err
          else
            return reply docList
    }
  ]

  server.route route
  next()

exports.register.attributes = {
  name : 'GetCalls'
  version : '1.0.0'
}
