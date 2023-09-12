import 'package:mongo_dart/mongo_dart.dart';
import '../draglike/Item.dart';

class DatabaseHelper {
  final String connectionString =
      'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/test?retryWrites=true&w=majority';

  Future<List<String>> fetchItemNames() async {
    final db = Db(connectionString);
    await db.open();
    final collection = db.collection('huatest');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => item['物品名稱'] as String).toList();
  }
}
