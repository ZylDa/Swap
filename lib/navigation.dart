import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swap/image_input.dart';
import 'package:swap/exchange_screen.dart';
import 'package:swap/product_launch.dart';

Future<String?> getUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('mail');
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Future<String?>? userEmail; // Declare userEmail as nullable Future
  @override
  void initState() {
    super.initState();
    userEmail = getUserEmail(); // Initialize userEmail in initState
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(204, 206, 205, 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.autorenew),
            label: 'Swap',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_a_photo),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        const ExchangeScreen(),
        Container(
          color: const Color.fromRGBO(12, 59, 46, 1),
          alignment: Alignment.center,
          child: const ProductLauch(),
        ),
        Container(
          color: const Color.fromRGBO(12, 59, 46, 1),
          alignment: Alignment.center,
          child: Text(
            '$userEmail\'s profile',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
