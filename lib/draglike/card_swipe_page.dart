import 'package:flutter/material.dart';

import './Item.dart';
import './card_item.dart';
import '../mongodb/drag_like_helper.dart';

class CardSwipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();

    return FutureBuilder<List<Item>>(
      future: databaseHelper
          .fetchItems(), // 使用 fetchItems() 函數來取得 Future<List<Item>> 物件
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available.');
        } else if (snapshot.data!.isEmpty) {
          return const Text('Data is empty.');
        } else {
          return PageView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              //return CardItem(item: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
