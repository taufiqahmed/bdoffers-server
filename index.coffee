
Hapi = require 'hapi'
Inert = require 'inert'
{ graphqlHapi } = require 'graphql-server-hapi'

myGraphQLSchema = require './schema.coffee'


server = new Hapi.Server()
server.connection {
  host: 'localhost'
  port: 3004
  routes: 
    cors: true
}

plugins = [
  {
    register: Inert
    options: {}
  }
  {
    register: graphqlHapi
    options: {
      path: '/graphql'
      graphqlOptions: {
        schema: myGraphQLSchema
      }
    }
  }
]

server.register plugins, (err)-> throw err if err






server.route {
  method: 'GET'
  path: '/offers/'
  handler: (request, reply)->
    db.offer.find {collection:'offers'}, (err, docList)=>
      unless docList.length is 0
        reply docList
}

server.route {
  method: 'POST'
  path: '/offers/'
  handler: (request, reply)->
    doc = request.payload
    doc.collection = 'offers'
    db.offer.insert doc, (err, newDoc)=>
      if newDoc
        return reply {id:newDoc._id, collection:newDoc.collection}
}

server.route {
  method: 'GET'
  path: '/offers/{id}'
  handler: (request, reply)->
    id = encodeURIComponent request.params.id
    db.offer.findOne {_id:id}, (err, doc)=>
      if doc
        return reply doc
}


server.start (err)=>
  throw err if err
  console.log 'Server running at', server.info.uri

