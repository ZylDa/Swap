import 'package:flutter/material.dart';
import './pages/auth_page.dart';

import 'screens/splash/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkFirstTimeUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 此时可以显示一个加载指示器或启动屏幕
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              // 处理错误情况
              return Text('Error: ${snapshot.error}');
            } else {
              bool isFirstTimeUser = snapshot.data ?? true;
              return MaterialApp(
                //debugShowCheckedModeBanner: false,
                title: 'Swap Demo',
                home: isFirstTimeUser ? SplashScreen() : const AuthPage(),
              );
            }
          }
        });
  }

  Future<bool> checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeUser') ?? true;

    if (isFirstTime) {
      // 如果是第一次使用应用程序，将isFirstTimeUser设置为false
      prefs.setBool('isFirstTimeUser', false);
    }

    return isFirstTime;
  }
}
