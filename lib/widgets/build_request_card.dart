import 'package:flutter/material.dart';
import 'package:swap/size_config.dart';

class RequestCard extends StatelessWidget {
  final String ownerName;
  final String itemName;
  final String expirationDate;
  final ImageProvider imageProvider;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  RequestCard({
    required this.ownerName,
    required this.itemName,
    required this.expirationDate,
    required this.imageProvider,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // 確保初始化

    double imageWidth = getProportionateScreenWidth(105);
    double imageHeight = getProportionateScreenHeight(105 + 5);
    // 計算相對位置 (40是自己調的)
    double cardWidth = getProportionateScreenWidth(317 + 20);
    double cardHeight = getProportionateScreenHeight(105 + 5);

    double buttonWidth = getProportionateScreenWidth(57 + 7);
    double buttonHeight = getProportionateScreenHeight(29 + 5);

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 左側圖片
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                image: imageProvider, // 用你的實際圖片替換
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 中間的文字信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  ownerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Expires in $expirationDate\d',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // 右側的按鈕
          Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(buttonWidth, buttonHeight), // 設置寬度和高度
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 196, 194, 178),
                    ),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 196, 194, 178),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(buttonWidth, buttonHeight), // 設置寬度和高度
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 196, 194, 178),
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
