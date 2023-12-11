import 'package:flutter/material.dart';

class WishlistInfo extends StatelessWidget {
  final String itemName;
  final String ownerName;
  final List<String> tags;
  final String requestTime;

  const WishlistInfo({
    super.key,
    required this.itemName,
    required this.ownerName,
    required this.tags,
    required this.requestTime,
  });

  // 定義共用的 TextStyle 變數
  final TextStyle customTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF8B8B8B),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name: $itemName', style: customTextStyle),
          const SizedBox(height: 20),
          Text('Owner: $ownerName', style: customTextStyle),
          const SizedBox(height: 20),
          Text('Tags: ${tags.join(", ")}', style: customTextStyle),
          const SizedBox(height: 20),
          Text('Request Time: $requestTime', style: customTextStyle),
        ],
      ),
    );
  }
}
