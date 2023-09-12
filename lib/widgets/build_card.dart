import 'package:flutter/material.dart';

import '../components/tag_widget.dart';

Widget buildCard({
  required String image,
  required String ownerName,
  required String itemName,
  required List<String> tags,
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0), // Outer padding for the card
    child: Container(
      width: 400, //300
      height: 600, //440
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 270, // 固定图像容器的宽度
            height: 270, // 固定图像容器的高度
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            itemName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tags.map((tag) => TagWidget(tag)).toList(),
          ),
        ],
      ),
    ),
  );
}
