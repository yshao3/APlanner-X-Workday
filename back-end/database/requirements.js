db.createCollection("requirements", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "degree_id", "category" ],
         properties: {
            degree_id: {
               bsonType: "int",
               description: "must be an integer and is required"
            },
            category: {
               bsonType: "array",
               description: "must be an array and is required"
            },

         }
      }
   }
})