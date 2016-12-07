
Hapi = require 'hapi'
Inert = require 'inert'
db = require './db.coffee'

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
  # Registering APIs module(plugin)
  {register: require './api/get-offer.coffee'}
  {register: require './api/add-offer.coffee'}
]

server.register plugins, (err)-> throw err if err


server.start (err)=>
  throw err if err
  console.log 'Server running at', server.info.uri

