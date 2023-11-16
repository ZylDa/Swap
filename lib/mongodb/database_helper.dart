import 'package:mongo_dart/mongo_dart.dart';

class DatabaseHelper {
  final String connectionString =
      'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net';

  Future<List<String>> fetchItemNames() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => item['物品名稱'] as String).toList();
  }

  //抓取資料庫中的圖片二進制編碼
  Future<List<BsonBinary>> fetchItemImages() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => _extractImageData(item)).toList();
  }

  // 抓取資料庫中的tags
  Future<List<List<String>>> fetchItemTags() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();

    List<List<String>> tags =
        items.map((item) => (item['tags'] as List).cast<String>()).toList();

    return tags;
  }

  //抓取資料庫中的owner
  Future<List<String>> fetchItemOwner() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => item['owner'] as String).toList();
  }

  //抓取符合owner資料的物品圖片
  Future<List<BsonBinary>> fetchItemImageByOwner(String ownerEmail) async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find({'owner': ownerEmail}).toList();
    await db.close();
    return items.map((item) => _extractImageData(item)).toList();
  }

  BsonBinary _extractImageData(Map<String, dynamic> item) {
    var binaryData = item['照片二進制'];
    return binaryData;
  }

  Future<void> writeExchangeRequest(
    String itemID,
    String currentUserEmail,
    String recipientEmail,
  ) async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');

    // 构建交换请求数据
    final exchangeRequest = {
      'itemID': itemID,
    };

    // 更新当前用户的 Wishlist 字段
    final updateCurrentUser = {
      r'$push': {'Wishlist': exchangeRequest},
    };

    // 更新接收者的 Request 字段
    final updateRecipient = {
      //'Request': recipientDoc?['Request'] + [exchangeRequest],
      r'$push': {'Request': exchangeRequest},
    };

    // 更新数据库中的文档
    await collection.update(
      where.eq('owner', currentUserEmail),
      updateCurrentUser,
    );

    await collection.update(
      where.eq('owner', recipientEmail),
      updateRecipient,
    );

    await db.close();
  }

  Future<List<String>> fetchItemIdsByOwner(String ownerEmail) async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find({'owner': ownerEmail}).toList();
    await db.close();
    return items.map((item) => item['_id'].toString()).toList();
  }

  Future<String> fetchItemOwnerById(String itemId) async {
    final db = await Db.create(
      'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority',
    );
    await db.open();
    final collection = db.collection('items');
    final item = await collection.findOne(where.eq('_id', itemId));
    await db.close();

    if (item != null) {
      return item['owner'] as String;
    }

    return ''; // 返回空字符串或适当的默认值，表示未找到
  }
}
