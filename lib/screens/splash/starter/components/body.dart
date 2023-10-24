import 'package:flutter/material.dart';
import 'package:swap/components/default_button.dart';
import 'package:swap/mongo_auth/login_or_register_page.dart';
import 'package:swap/screens/splash/starter/components/splash_content.dart';

import '../../../../color_constants.dart';
import 'package:swap/size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "歡迎加入Swap計畫，讓我們告訴你怎麼使用吧！",
      "image": "assets/images/onboard_test_2.jpg"
    },
    {"text": "如何上架呢？", "image": "assets/images/onboard_test_1.jpg"},
    {"text": "如何交換呢？", "image": "assets/images/onboard_test_3.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"] ?? '',
                  text: splashData[index]['text'] ?? '',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(25),
                  getProportionateScreenWidth(25),
                  getProportionateScreenWidth(25),
                  getProportionateScreenWidth(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const VerticalSpacing(of: 40),
                  DefaultButton(
                    text: getButtonText(),
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginOrRegisterPage()),
                      );
                    }, //onpressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 30 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  String getButtonText() {
    if (currentPage == splashData.length - 1) {
      return "Start";
    } else {
      return "Skip";
    }
  }
}
