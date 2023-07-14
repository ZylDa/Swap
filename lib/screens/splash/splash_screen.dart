import 'package:flutter/material.dart';

import '../../size_config.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key}); //設定onBoarding 頁的routeName
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(), //使用body.dart 的Body()
    );
  }
}
