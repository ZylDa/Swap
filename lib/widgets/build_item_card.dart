import 'package:flutter/material.dart';

Widget buildItemCard({
  required String itemName,
  required Image decodedImage, // 直接使用Image類型
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
                child: decodedImage,
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
    ),
  );
}
