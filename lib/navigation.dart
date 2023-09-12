import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swap/draglike/card_swipe_page.dart';

import 'package:swap/image_input.dart';
import 'package:swap/exchange_page.dart';
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
  File? _capturedImage;

  //final _imageInputKey = GlobalKey<_ImageInputState>();
  //void takePicture() {
  //  _imageInputKey.currentState?.takePicture();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(204, 206, 205, 1),
        onDestinationSelected: (int index) {
          if (index == 1) {
            _takePicture();
          } else {
            setState(() {
              currentPageIndex = index;
            });
          }
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
        ProductLaunch(capturedImage: _capturedImage),
        //Container(
        //  color: const Color.fromRGBO(12, 59, 46, 1),
        //  alignment: Alignment.center,
        //  child: ImageInput(),
        //),
        Container(
          color: const Color.fromRGBO(12, 59, 46, 1),
          alignment: Alignment.center,
          child: CardSwipePage(),
        ),
      ][currentPageIndex],
    );
  }

  void _takePicture() async {
    File? imageFile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageInput(
          onPictureTaken: (image) => _onPictureTaken(image),
        ),
      ),
    );

    if (imageFile != null) {
      setState(() {
        _capturedImage = imageFile;
        //currentPageIndex = 1; // Navigate to the "Add" tab
      });
    }
  }

  void _onPictureTaken(File image) {
    //_capturedImage = image;
    setState(() {
      currentPageIndex = 1; // Navigate to the "Add" tab
    });
  }
}
