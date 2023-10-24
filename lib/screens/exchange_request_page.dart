import 'package:flutter/material.dart';
import 'package:swap/size_config.dart';

class ExchangeRequestPage extends StatelessWidget {
  final String itemName;

  const ExchangeRequestPage({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // 確保初始化

    double imageWidth = getProportionateScreenWidth(200);
    double imageHeight = getProportionateScreenHeight(200);
    // 計算相對位置 (40是自己調的)
    double topImagePosition = getProportionateScreenHeight(203 - 40);
    double topWhitePosition = getProportionateScreenHeight(844 - (567 + 40));

    return Column(
      children: [
        //底色
        Expanded(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              color: Color(0xFFE9E8DB),
              shape: RoundedRectangleBorder(side: BorderSide(width: 0)),
              /*shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
              */
            ),
            child: Stack(
              children: [
                //標題
                const Positioned(
                  top: 80,
                  left: 30,
                  child: Text(
                    'Exchange requests',
                    style: TextStyle(
                      color: Color(0xFF151515),
                      fontSize: 24,
                      fontFamily: 'Basic',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.80,
                    ),
                  ),
                ),
                //白色區域
                Positioned(
                  top: topWhitePosition,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // 陰影的顏色和透明度
                          spreadRadius: 1, // 陰影擴散的範圍
                          blurRadius: 3, // 陰影模糊的程度
                          offset: const Offset(0, 3), // 陰影的偏移量
                        ),
                      ],
                    ),
                  ),
                ),
                //a 200x200 Positioned image
                Positioned(
                  top: topImagePosition,
                  left: (SizeConfig.screenWidth ?? 0) / 2 - 100, // 設置水平置中
                  child: Container(
                    width: imageWidth,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), // 設置圓角半徑
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // 陰影的顏色和透明度
                          spreadRadius: 2, // 陰影擴散的範圍
                          blurRadius: 5, // 陰影模糊的程度
                          offset: const Offset(0, 3), // 陰影的偏移量
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/dog.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
