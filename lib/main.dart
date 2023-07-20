import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swap/navigation.dart';
import 'package:swap/mongo_auth/login_or_register_page.dart';

import '/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('loggedin');

    if (loggedIn == true) {
      return const Navigation();
    } else {
      return const LoginOrRegisterPage();
    }
  }

  Future<bool> checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeUser') ?? true;

    if (isFirstTime) {
      // 如果是第一次使用應用程序，將isFirstTimeUser設置為false
      prefs.setBool('isFirstTimeUser', false);
    }

    return isFirstTime;
  }

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
                home: isFirstTimeUser
                    ? const SplashScreen()
                    : const LoginOrRegisterPage(),
              );
            }
          }
        });
  }
}
