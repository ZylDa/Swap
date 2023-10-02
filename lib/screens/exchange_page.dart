import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:swap/navigation.dart';
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
  List<String> othersItemNames = [];
  List<String> othersItemImages = [];
  List<String> othersItemOwner = [];
  List<List<String>> othersItemTags = [];

  @override
  void initState() {
    super.initState();
    // 在初始化时从数据库获取物品名称、图片、品牌名和颜色
    fetchItemInfoExchange();
  }

  Future<void> fetchItemInfoExchange() async {
    // 获取当前用户的email
    String currentUserEmail = (await getUserEmail()) ?? ''; // 使用空字串作為默認值
    List<String> names = await DatabaseHelper().fetchItemNames();
    List<String> images = await DatabaseHelper().fetchItemImages();
    List<String> logos = await DatabaseHelper().fetchItemLogo();
    List<String> owners = await DatabaseHelper().fetchItemOwner();
    List<List<String>> colors = await DatabaseHelper().fetchItemColor();

    List<List<String>> tags = [];

    // 合并品牌名和颜色为标签
    for (int i = 0; i < logos.length; i++) {
      List<String> combinedTags = [logos[i], ...colors[i]]; // 合并品牌名和颜色
      tags.add(combinedTags);
    }

    // 過濾"其他人的物品"
    List<int> othersItemIndices = List.generate(owners.length, (index) => index)
        .where((index) => owners[index] != currentUserEmail)
        .toList();

    if (mounted) {
      setState(() {
        othersItemNames =
            othersItemIndices.map((index) => names[index]).toList();
        othersItemImages =
            othersItemIndices.map((index) => images[index]).toList();
        othersItemOwner =
            othersItemIndices.map((index) => owners[index]).toList();
        othersItemTags = tags;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 194, 178),
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
                        backgroundColor:
                            const Color.fromARGB(255, 196, 194, 178),
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
              itemCount: othersItemNames.length,
              itemBuilder: (BuildContext context, int index) {
                String itemName = othersItemNames[index];
                String imageBase64 = othersItemImages[index];
                String itemOwner = othersItemOwner[index];
                List<String> tags = othersItemTags[index];

                return buildCard(
                  imageBase64: imageBase64,
                  ownerName: itemOwner,
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
