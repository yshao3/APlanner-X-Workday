db.createCollection("degrees", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "type", "major", "college", "school", "is_minor" ],
         properties: {
            type: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            major: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            college: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            school: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            is_minor: {
               bsonType: [ "boolean" ],
               description: "must be a boolean and is required"
            }
         }
      }
   }
})
