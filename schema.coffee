{
  graphql,
  GraphQLSchema,
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLList
} = require 'graphql'

Datastore = require 'nedb'
db = {}
db.offer = new Datastore {filename: './offers.db'}
db.offer.loadDatabase()


OffersType = new GraphQLObjectType {
  name: 'Offers'
  description: 'Fetch All Offers'
  fields: ()=> 
    return ({
      title: 
        type: GraphQLString
      brand:
        type: GraphQLString
      discount:
        type: GraphQLInt
      startDate:
        type: GraphQLString
      endDate:
        type: GraphQLString
    })
}

myGraphQLSchema = new GraphQLSchema {
  query: new GraphQLObjectType {
    name: 'RootQueryType'
    fields:
      offers:
        type: new GraphQLList OffersType
        resolve: ()->
          db.offer.find {collection:'offers'}, (err, docList)=>
            return docList
  }
}



module.exports = myGraphQLSchema