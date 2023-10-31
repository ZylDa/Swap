import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swap/mongodb/database_helper.dart';
import 'package:swap/navigation.dart';
import 'package:swap/size_config.dart';

class ItemSelector extends StatefulWidget {
  const ItemSelector({super.key, required this.handleExchangeRequest});
  final Function(String) handleExchangeRequest; // 回調函數來處理交換請求

  @override
  ItemSelectorState createState() => ItemSelectorState();
}

class ItemSelectorState extends State<ItemSelector> {
  List<String> myItemImages = [];
  List<String> myItemIds = [];
  CarouselSlider? carouselSlider;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 在初始化时从数据库获取物品名称、图片、品牌名和颜色
    fetchItemImage();
    print(getUserEmail());
  }

  Future<void> fetchItemImage() async {
    // 获取当前用户的email
    String currentUserEmail = (await getUserEmail()) ?? ''; // 使用空字串作為默認值
    final dbHelper = DatabaseHelper();
    List<String> images =
        await DatabaseHelper().fetchItemImageByOwner(currentUserEmail);
    List<String> itemIds = await dbHelper.fetchItemIdsByOwner(currentUserEmail);

    if (mounted) {
      setState(() {
        myItemImages = images;
        myItemIds = itemIds;
        // 創建 CarouselSlider
        carouselSlider = createCarouselSlider();
      });
    }
  }

  CarouselSlider createCarouselSlider() {
    return CarouselSlider(
      items: myItemImages.asMap().entries.map((entry) {
        final index = entry.key;
        final base64String = entry.value;
        List<int> imageBytes = base64Decode(base64String);
        Image image = Image.memory(
          Uint8List.fromList(imageBytes),
          fit: BoxFit.cover,
        );

        return GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            widget.handleExchangeRequest(myItemIds[index]); // 处理交换请求
          },
          child: Container(
            width: 75,
            height: 75,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ClipOval(
              child: image,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 0.3,
        height: 80.0,
        onPageChanged: (index, reason) {
          setState(() {
            //增加功能
            currentIndex = index;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (getUserEmail() != null) {
      return SizedBox(
        width: SizeConfig.screenWidth,
        height: 85,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 196, 194, 178),
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Center(
              child:
                  carouselSlider ?? const SizedBox(), // 使用已創建的 carouselSlider
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: SizeConfig.screenWidth,
        height: 85,
        child: const Column(
          children: [
            Text(
              'No items yet.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'basic',
              ),
            ),
            Text(
              'Add items that you don\'t need then exchange with others!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'basic',
              ),
            ),
          ],
        ),
      );
    }
  }
}
