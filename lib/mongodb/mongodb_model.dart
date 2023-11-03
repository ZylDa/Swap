import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    String id;
    BsonBinary binary; 
    String owner;
    List<String> tag;
    String name;

    MongoDbModel({
        required this.id,
        required this.binary, 
        required this.owner,
        required this.tag,
        required this.name,
    });

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        binary: BsonBinary.from(json["照片二進制"]), // 转换为 Uint8List
        owner: json["owner"],
        tag: List<String>.from(json["tags"].map((x) => x)),
        name: json["物品名稱"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "照片二進制": binary, 
        "owner": owner,
        "tags": List<dynamic>.from(tag.map((x) => x)),
        "物品名稱": name,
    };
}
