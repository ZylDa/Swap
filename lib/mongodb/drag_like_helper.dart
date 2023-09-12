import 'package:mongo_dart/mongo_dart.dart';
import './constant.dart';
import '../draglike/Item.dart';

class DatabaseHelper {
  //final mongo.Db _db = mongo.Db(_mongoUrl);

  Future<List<Item>> fetchItems() async {
    final db = await Db.create(
      'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/test?retryWrites=true&w=majority',
    );

    try {
      await db.open();

      print('Database connection opened.');

      final itemsCollection = db.collection('huatest');
      print('Items collection: $itemsCollection');
      final itemsData = await itemsCollection.find().toList();
      print('Items data from database: $itemsData');

      print('Data fetched successfully.');

      await db.close();

      print('Database connection closed.');

      return itemsData.map((itemData) {
        return Item(
          name: itemData['logo'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      await db.close();
      print('Database connection closed due to error.');
      return []; // Return an empty list in case of error.
    }
  }
}
