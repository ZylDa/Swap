import 'package:flutter/material.dart';

import 'package:swap/color_constants.dart';
import 'package:swap/size_config.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double sizedBoxHeight = getProportionateScreenHeight(142 - 70);
    double infoWidth = getProportionateScreenWidth(304);
    double infoHeight = getProportionateScreenHeight(114);
    double imageWidth = getProportionateScreenWidth(262);
    double imageHeight = getProportionateScreenHeight(267);
    double rowSizedBoxWidth = getProportionateScreenWidth(35);
    double rowSizedBoxWidth2 = getProportionateScreenWidth(73);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: sizedBoxHeight),
                const Text(
                  'Congrats!',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'basic',
                      color: kTextLightColor),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Swap',
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'basic',
                      color: kTextColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 14,
                ),
                Image.asset(
                  'assets/images/success.jpg',
                  width: imageWidth,
                  height: imageHeight,
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: infoWidth,
                  height: infoHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF8B8B8B),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: rowSizedBoxWidth,
                          ),
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'basic',
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: rowSizedBoxWidth2,
                          ),
                          const Text(
                            '小謙',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'basic',
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: rowSizedBoxWidth,
                          ),
                          const Text(
                            'E-mail',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'basic',
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: rowSizedBoxWidth2-2,
                          ),
                          const Text(
                            '109306088@nccu.edu.tw',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'basic',
                              color: kTextColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Contact him/her right now!',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'basic',
                    color: kTextLightColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 29,
            top: 61,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.close), // 使用叉叉的圖標
              onPressed: () {
                Navigator.of(context).pop(); // 返回上一頁的操作
              },
            ),
          ),
        ],
      ),
    );
  }
}
