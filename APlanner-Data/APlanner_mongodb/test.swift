import MongoKitten

let myDatabase = try MongoKitten.Database("mongodb://localhost/test")
let myCollection = myDatabase["test"]

for document in try myCollection.find({}) {
    print (document)
}
