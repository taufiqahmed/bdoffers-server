
@generateGraphqlSchema = (db)->

  {
    graphql,
    GraphQLSchema,
    GraphQLObjectType,
    GraphQLString,
    GraphQLInt,
    GraphQLList
  } = require 'graphql'
  Promise = require 'promise'

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
            return new Promise (resolve, reject)=>
              db.offer.find {collection: 'offers'}, (err, docList)=>
                if err
                  reject err
                else
                  resolve docList
            
    }
  }

  return { myGraphQLSchema }

