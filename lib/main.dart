import 'package:flutter/material.dart';
import 'package:swap/routes.dart';

import 'screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Swap Demo',

      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
