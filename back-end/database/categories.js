db.createCollection("categories", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "pool", "is_elective"],
         properties: {
            pool: {
               bsonType: "array",
               description: "must be an array and is required"
            },
            is_elective:{
               bsonType: "bool",
               description: "must be a boolean and is required"
            }
         }
      }
   }
})