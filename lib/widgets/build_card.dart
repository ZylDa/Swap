import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';

import '../components/tag_widget.dart';

Widget buildCard({
  required String imageBase64,
  required String ownerName,
  required String itemName,
  required List<String> tags, // 包含品牌名和颜色的标签列表
}) {
  List<int> imageBytes = base64Decode(imageBase64);
  Image image = Image.memory(
    Uint8List.fromList(imageBytes),
    fit: BoxFit.contain,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            ownerName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 270,
            height: 270,
            child: image,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            itemName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 3.0,
            spacing: 5.0,
            children: tags.map((tag) {
              return TagWidget(tag);
            }).toList(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    ),
  );
}
