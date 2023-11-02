import 'dart:async';
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
    final db = await Db.create(MONGO_URL_HUA);
    await db.open();
    final collection = db.collection(COLLECTION_NAME_HUA);
    //await connect();
    try {
      var result = await collection.insert(data.toJson());
      await db.close();
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> update(
      String id, String name, List<String> tags) async {
    //await connect();
    final db = await Db.create(MONGO_URL_HUA);
    await db.open();
    final collection = db.collection(COLLECTION_NAME_HUA);
    try {
      await collection.update(
          where.eq('_id', id), modify.set('物品名稱', name).set('tags', tags));
      await db.close();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<void> changeStream(String specificId, Function fun) async {
    final db = await Db.create(MONGO_URL_HUA);
    await db.open();
    final collection = db.collection(COLLECTION_NAME_HUA);
    
    var stream = collection.watch(
      <Map<String, Object>>[
        {
          r'$match': {
            'operationType': 'update',
            'fullDocument._id': specificId,
          }
        }
      ],
      changeStreamOptions: ChangeStreamOptions(
        fullDocument: 'updateLookup',
      ),
    );

    var controller = stream.listen((changeEvent) async{
      String name = changeEvent.fullDocument?['物品名稱'];
      List tags = changeEvent.fullDocument?['tags'];
      String operationType = changeEvent.operationType ?? '';
      print('Received MongoDB changes');
      print('operationType: $operationType');
      print('name: $name');
      print('tags: $tags');

      // Create a Map with name and tags
      Map<String, dynamic> result = {
        'name': name,
        'tags': tags,
      };

      await db.close();
      fun(result); // Pass the result to the provided function
    });
  }
}
