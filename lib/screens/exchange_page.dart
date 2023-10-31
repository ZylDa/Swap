import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:swap/navigation.dart';
import '../widgets/build_card.dart';
import '../widgets/item_selector.dart';
import '../mongodb/database_helper.dart';
import '../notification.dart';

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
  List<Uint8List> othersItemImagesBytes = [];

  @override
  void initState() {
    super.initState();
    fetchItemInfoExchange();
  }

  Future<void> fetchItemInfoExchange() async {
    String currentUserEmail = (await getUserEmail()) ?? '';
    List<String> names = await DatabaseHelper().fetchItemNames();
    List<String> images = await DatabaseHelper().fetchItemImages();
    //List<String> logos = await DatabaseHelper().fetchItemLogo();
    List<String> owners = await DatabaseHelper().fetchItemOwner();
    //List<List<String>> colors = await DatabaseHelper().fetchItemColor();

    List<List<String>> tags = await DatabaseHelper().fetchItemTags();

    /*for (int i = 0; i < logos.length; i++) {
      List<String> combinedTags = [logos[i], ...colors[i]];
      tags.add(combinedTags);
    }*/

    List<int> othersItemIndices = List.generate(owners.length, (index) => index)
        .where((index) => owners[index] != currentUserEmail)
        .toList();

    List<Uint8List> imagesBytes =
        await Future.wait(images.map((imageBase64) async {
      return await decodeImage(imageBase64);
    }));

    if (mounted) {
      setState(() {
        othersItemNames =
            othersItemIndices.map((index) => names[index]).toList();
        othersItemImages = 
            othersItemIndices.map((index) => images[index]).toList();
        othersItemImagesBytes = 
            othersItemIndices.map((index) => imagesBytes[index]).toList();
        othersItemOwner =
            othersItemIndices.map((index) => owners[index]).toList();
        othersItemTags = 
            othersItemIndices.map((index) => tags[index]).toList();
      });
    }
  }

  void handleExchangeRequest(String itemId) async {
    String currentUserEmail = (await getUserEmail()) ?? '';
    //String itemId = await DatabaseHelper().fetchItemIdByIndex(itemIndex);
    String selectedOwner = await DatabaseHelper().fetchItemOwnerById(itemId);

    // 调用处理交换请求的方法
    await DatabaseHelper()
        .writeExchangeRequest(itemId, currentUserEmail, selectedOwner);

    // 其他处理逻辑，例如显示确认消息
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exchange request sent successfully!'),
      ),
    );
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
                    return NotificationWidget();
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
                Uint8List imageBytes = othersItemImagesBytes[index];
                String itemOwner = othersItemOwner[index];
                List<String> tags = othersItemTags[index];

                return BuildCard(
                  imageBytes: imageBytes,
                  ownerName: itemOwner,
                  itemName: itemName,
                  tags: tags,
                  onExchangePressed: () {
                    handleExchangeRequest(index.toString());
                  },
                );
              },
              layout: SwiperLayout.TINDER,
              itemWidth: 400,
              itemHeight: 500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ItemSelector(
              handleExchangeRequest: handleExchangeRequest,
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> decodeImage(String imageBase64) async {
    try {
      return base64Decode(imageBase64);
    } catch (error) {
      print('Error decoding image: $error');
      return Uint8List(0); // 返回空的 Uint8List，以避免在图像无效时出现问题
    }
  }

  static Uint8List _decodeImage(String imageBase64) {
    return base64Decode(imageBase64);
  }
}
