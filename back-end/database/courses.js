db.createCollection("courses", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "subject", "number"],
         properties: {
            subject: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            number: {
               bsonType: "string",
               description: "must be a string and is required"
            },
			title: {
               bsonType: "string",
               description: "must be a string and is not required"
            },
			prerequisite: {
               bsonType: "array",
               description: "must be a arrays and is not required"
            },
			corequisite: {
               bsonType: "array",
               description: "must be a arrays and is not required"
            },
			tags: {
               bsonType: "array",
               description: "must be a arrays and is not required"
            },
         when_offer: {
			   bsonType: "array",
               //enum: [ "Fall", "Spring", "Summer", "winter", "Fall and Spring"],
            description: "arrays of enum and is not required"
			   //"can only be one of the enum values and is required"
            },
			min_unit: {
				bsonType: "int",
				minimum: 0,
				description: "must be an integer and is not required"
			},
			description: {
				bsonType: "string",
            description: "must be a string and is not required"
			   }
         }
      }
   }
})
