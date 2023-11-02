import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../components/tag_widget.dart';

class BuildCard extends StatelessWidget {
  final Uint8List imageBytes;
  final String ownerName;
  final String itemName;
  final List<String> tags;
  final VoidCallback onExchangePressed;

  const BuildCard({
    Key? key,
    required this.imageBytes,
    required this.ownerName,
    required this.itemName,
    required this.tags,
    required this.onExchangePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: onExchangePressed,
              child: Container(
                width: 270,
                height: 270,
                child: image,
              ),
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
}
