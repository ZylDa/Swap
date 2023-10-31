import 'package:flutter/material.dart';
import 'package:swap/notification.dart';

// NOT USED

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() {
    return _ExchangeScreenState();
  }
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 59, 46, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 107, 87),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 300,
              height: 440,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(255, 255, 255, 1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/doll.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(58, 58),
                    ),
                  ),
                ),
                Container(
                  width: 91,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(241, 241, 241, 1),
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(91, 90),
                    ),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/curler.png'),
                        fit: BoxFit.fill),
                    border: Border.all(
                      color: Colors.white,
                      width: 6,
                    ),
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(58, 58),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
