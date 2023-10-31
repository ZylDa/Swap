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

  //抓取資料庫中的圖片base64編碼
  Future<List<String>> fetchItemImages() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => item['照片base64'] as String).toList();
  }

  /*抓取資料庫中的logo
  Future<List<String>> fetchItemLogo() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();
    return items.map((item) => item['logo'] as String).toList();
  }

  // 抓取資料庫中的顏色tag
  Future<List<List<String>>> fetchItemColor() async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find().toList();
    await db.close();

    // 假设 '顏色' 字段是一个 String 数组的数组，将其转换为 List<List<String>>
    List<List<String>> colors =
        items.map((item) => (item['顏色'] as List).cast<String>()).toList();

    return colors;
  }
    */

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

  //抓取符合owner資料的物品
  Future<List<String>> fetchItemImageByOwner(String ownerEmail) async {
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('items');
    final items = await collection.find({'owner': ownerEmail}).toList();
    await db.close();
    return items.map((item) => item['照片base64'] as String).toList();
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
    final item =
        await collection.findOne(where.id(ObjectId.fromHexString(itemId)));
    await db.close();

    if (item != null) {
      return item['owner'] as String;
    }

    return ''; // 返回空字符串或适当的默认值，表示未找到
  }
}
