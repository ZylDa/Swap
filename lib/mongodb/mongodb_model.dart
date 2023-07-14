// To parse this JSON data, do
//
//     final mongodbModel = mongodbModelFromJson(jsonString);

import 'dart:convert';

MongodbModel mongodbModelFromJson(String str) =>
    MongodbModel.fromJson(json.decode(str));

String mongodbModelToJson(MongodbModel data) => json.encode(data.toJson());

class MongodbModel {
  //String id;
  String name;
  List<String> tag;

  MongodbModel({
    //required this.id,
    required this.name,
    required this.tag,
  });

  factory MongodbModel.fromJson(Map<String, dynamic> json) => MongodbModel(
        //id: json["id"],
        name: json["name"],
        tag: List<String>.from(json["tag"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "name": name,
        "tag": List<dynamic>.from(tag.map((x) => x)),
      };
}

