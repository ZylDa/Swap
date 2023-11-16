import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swap/navigation.dart';
import 'package:swap/mongo_auth/login_or_register_page.dart';

import '/screens/splash/splash_screen.dart';

void main() {
  runAppWithLoginStatus();
}

void runAppWithLoginStatus() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('loggedIn') ?? false;

  runApp(
    MaterialApp(
      title: 'Swap Demo',
      home: _MyApp(loggedIn: loggedIn),
    ),
  );
}

class _MyApp extends StatefulWidget {
  const _MyApp({required bool loggedIn});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  Future<Widget?> autoLogin() async {
    //showLoadingDialog();  // 顯示 loading dialog
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('loggedIn');

    if (loggedIn == true) {
      return const Navigation();
    } else {
      Navigator.of(context).pop(); // 移除 loading dialog
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
                debugShowCheckedModeBanner: false,
                title: 'Swap Demo',
                home: isFirstTimeUser
                    ? const SplashScreen()
                    : FutureBuilder<Widget?>(
                        future: autoLogin(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Widget?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return snapshot.data ??
                                const SizedBox(); // 使用 ?? 避免 null
                          }
                        },
                      ),
              );
            }
          }
        });
  }
}
