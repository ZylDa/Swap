import 'package:flutter/material.dart';

import '../widgets/build_personal_card.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //底色
        Container(
          width: 390,
          height: 722,
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: Color(0xFFE9E8DB),
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            //圖層2
            children: [
              Container(
                width: 389,
                height: 575,
                margin: const EdgeInsets.only(top: 147),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(45)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 30, bottom: 30),
                      child: Text(
                        '我的物品',
                        style: TextStyle(
                          color: Color(0xFF151515),
                          fontSize: 16,
                          fontFamily: 'Basic',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.80,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildItemCard("Birkenstock涼鞋",
                              "https://via.placeholder.com/128x128"),
                          buildItemCard(
                              "Nike大腰包", "https://via.placeholder.com/128x128"),
                          buildItemCard("Nike dunk",
                              "https://via.placeholder.com/128x128"),
                          // 在這裡添加更多的物品卡片
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 40, left: 30, bottom: 30),
                          child: Text(
                            '願望物品',
                            style: TextStyle(
                              color: Color(0xFF151515),
                              fontSize: 16,
                              fontFamily: 'Basic',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.80,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildItemCard("網格掛籃",
                                  "https://via.placeholder.com/128x128"),
                              buildItemCard("Financial Accounting",
                                  "https://via.placeholder.com/128x128"),
                              buildItemCard("500ml水杯",
                                  "https://via.placeholder.com/128x128"),
                              // 在這裡添加更多的物品卡片
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
