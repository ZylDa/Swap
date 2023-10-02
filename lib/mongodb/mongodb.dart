import 'dart:developer';

import 'mongodb_model.dart';

import 'constant.dart';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, collection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    //print(await collection.find().toList());
    //await collection.insertOne({'name': 'John', 'email': '123@qwe.com', 'password': 'john123'});
  }

  static Future<String> insert(MongodbModel data) async {
    connect();
    try {
      var result = await collection.insert(data.toJson());
      await db.close();
      return result;
    } catch (e) {
      //print(e.toString());
      return e.toString();
    }
  }
}
