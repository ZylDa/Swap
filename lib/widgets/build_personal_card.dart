import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

Widget buildItemCard({
  required String itemName,
  required String imageBase64,
}) {
  List<int> imageBytes = base64Decode(imageBase64);
  Image image = Image.memory(
    Uint8List.fromList(imageBytes),
    fit: BoxFit.contain,
  );

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    width: 128,
    height: 184,
    child: Stack(
      children: [
        // 底部容器，用於添加陰影
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: image,
            ),
            SizedBox(
              width: 128,
              height: 56,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      color: Color(0xFF151515),
                      fontSize: 14,
                      fontFamily: 'Basic',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
