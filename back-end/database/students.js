db.createCollection("students", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "name", "degree_id", "expected_grad_time" ],
         properties: {
            name: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            degree_id: {
               bsonType: "array",
               description: "must be an array and is required"
            },
            prev_courses: {
               bsonType: "array",
               description: "must be an array and is not required"
            },
            cur_courses: {
               bsonType: "array",
               description: "must be an array and is not required"
            },
            expected_grad_time{
               bsonType: "date",
               description: "must be a date and is required"
            }
         }
      }
   }
})