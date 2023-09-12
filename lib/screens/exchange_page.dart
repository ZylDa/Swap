import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../widgets/build_card.dart';
import '../item_selector.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() {
    return _ExchangeScreenState();
  }
}

class _ExchangeScreenState extends State<ExchangeScreen> {
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
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return buildCard(
                    image: 'assets/images/doll.png',
                    ownerName: 'Owner 1',
                    itemName: 'Item 1',
                    tags: ['Tag1', 'Tag2'],
                  );
                } else if (index == 1) {
                  return buildCard(
                    image: 'assets/images/corgi.jpg',
                    ownerName: 'Owner 2',
                    itemName: 'Item 2',
                    tags: ['Tag3', 'Tag4'],
                  );
                } else if (index == 2) {
                  return buildCard(
                    image: 'assets/images/dog.jpeg',
                    ownerName: 'Owner 3',
                    itemName: 'Item 3',
                    tags: ['Tag5', 'Tag6'],
                  );
                }
                return Container(); // Placeholder for other indices
              },
              itemCount: 3, // Replace with the number of cards you want
              layout: SwiperLayout.TINDER, // Choose your preferred layout
              itemWidth: 400,
              itemHeight: 500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0), // 設定上邊距
            child: ItemSelector(),
          ),
        ],
      ),
    );
  }
}
