import 'package:flutter/material.dart';
import 'package:swap/constants.dart';
import 'package:swap/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VerticalSpacing(of: 25),
        Text(
          "一拍即合-Swap",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalSpacing(of: 16),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: kTextColor,
              height: 1.5,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
        ),
        const VerticalSpacing(of: 40),
        Image.asset(
          image,
          height: getProportionateScreenHeight(400),
          width: double.infinity,
        ),
      ],
    );
  }
}
