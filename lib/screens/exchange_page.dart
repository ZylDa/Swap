import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../widgets/build_card.dart';
import '../widgets/item_selector.dart';
import '../mongodb/database_helper.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() {
    return _ExchangeScreenState();
  }
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  List<String> itemNames = [];
  List<String> itemImages = [];
  List<List<String>> itemTags = [];

  @override
  void initState() {
    super.initState();
    // 在初始化时从数据库获取物品名称、图片、品牌名和颜色
    fetchItemData();
  }

  Future<void> fetchItemData() async {
    List<String> names = await DatabaseHelper().fetchItemNames();
    List<String> images = await DatabaseHelper().fetchItemImages();
    List<String> logos = await DatabaseHelper().fetchItemLogo();
    List<List<String>> colors = await DatabaseHelper().fetchItemColor();

    List<List<String>> tags = [];

    // 合并品牌名和颜色为标签
    for (int i = 0; i < logos.length; i++) {
      List<String> combinedTags = [logos[i], ...colors[i]]; // 合并品牌名和颜色
      tags.add(combinedTags);
    }

    setState(() {
      itemNames = names;
      itemImages = images;
      itemTags = tags;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(1, 196, 194, 178),
        title: const Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.notification_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: const Color.fromARGB(1, 196, 194, 178),
                        title: const Text('Notification'),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Swiper(
              itemCount: itemNames.length,
              itemBuilder: (BuildContext context, int index) {
                String itemName = itemNames[index];
                String imageBase64 = itemImages[index];
                List<String> tags = itemTags[index];

                return buildCard(
                  imageBase64: imageBase64,
                  ownerName: 'Owner $index',
                  itemName: itemName,
                  tags: tags,
                );
              },
              layout: SwiperLayout.TINDER,
              itemWidth: 400,
              itemHeight: 500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: ItemSelector(),
          ),
        ],
      ),
    );
  }
}
