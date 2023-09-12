import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItemSelector extends StatefulWidget {
  @override
  _ItemSelectorState createState() => _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector> {
  List<String> itemImages = [
    'assets/images/curler.png',
    'assets/images/nike.jpg',
    'assets/images/birkenstock.jpg',
    'assets/images/yamaha.jpg',
    // Add more image paths as needed
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 設定寬度
      height: 85, // 設定高度
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 85, // 設定外框寬度
              height: 85, // 設定外框高度
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          Center(
            child: CarouselSlider(
              items: itemImages.map((imagePath) {
                return Container(
                  width: 75, // 設定圖片寬度
                  height: 75, // 設定圖片高度
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.35,
                height: 85.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
