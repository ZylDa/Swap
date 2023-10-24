// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  String id;
  String owner;
  String name;
  List<String> tag;
  String image;

  MongoDbModel({
    required this.id,
    required this.owner,
    required this.name,
    required this.tag,
    required this.image,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        owner: json["owner"],
        name: json["name"],
        tag: List<String>.from(json["tag"].map((x) => x)),
        image: json["照片base64"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner,
        "name": name,
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "照片base64": image,
      };
}
