import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swap/image_input.dart';
import 'package:swap/screens/exchange_page.dart';
import 'package:swap/product_launch.dart';
import 'package:swap/screens/personal_page.dart';

import 'mongodb/mongodb.dart';

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
  String? _id;

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
          setState(() {
            currentPageIndex = index;
          });
          if (index == 1) {
            _takePicture(); // Call _takePicture function directly when Add tab is tapped
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

        //ProductLaunch(capturedImage: _capturedImage, id: _id),
        //Container(
        //  color: const Color.fromRGBO(12, 59, 46, 1),
        //  alignment: Alignment.center,
        //  child: ImageInput(),
        //),
        Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          alignment: Alignment.center,
          //child: const Text('user'),
        ),
        const PersonalPage(),
      ][currentPageIndex],
    );
  }

  void _takePicture() async {
    //File? imageFile =
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageInput(
          onInsertId: _onInsertId,
          onPictureTaken: (image) => _onPictureTaken(image),
        ),
      ),
    );

    // if (imageFile != null) {
    //   setState(() {
    //     _capturedImage = imageFile;
    //     currentPageIndex = 1; // Navigate to the "Add" tab
    //   });
    // }
  }

  Future<void> _onInsertId(String id) async {
    _id = id;
    MongoDatabase.changeStream(_id!, _toProduct);
    // var result = await MongoDatabase.changeStreamOG(_id!, _toProduct);
    // print('return name: $result[\'name\']');
  }

  void _onPictureTaken(File image) {
    _capturedImage = image;
  }

  void _toProduct(Map map) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductLaunch(
          capturedImage: _capturedImage,
          id: _id,
          itemName: map['name'],
          tags: map['tags'],
        ),
      ),
    );
  }
}
