import 'dart:developer';

import 'mongodb_model.dart';

import 'constant.dart';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, collection;
  static connect() async {
    final db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    //print(await collection.find().toList());
    //await collection.insertOne({'name': 'John', 'email': '123@qwe.com', 'password': 'john123'});
  }

  static Future<dynamic> insert(MongoDbModel data) async {
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

  static Future<dynamic> update(
      String id, String name, List<String> tags) async {
    connect();
    try {
      //var result = await collection.update(data.toJson());
      // var result = await collection.findOne({"_id": id});
      // result['name'] = name;
      // result['tag'] = tags;
      // var response = await collection.update(result);
      // inspect(response);
      await collection.update(
          where.eq('_id', id), modify.set('name', name).set('tag', tags));
      await db.close();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
