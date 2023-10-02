import 'package:flutter/material.dart';
import 'package:swap/mongodb/database_helper.dart';
import 'package:swap/navigation.dart';
import 'package:swap/size_config.dart';
import 'package:swap/components/loading.dart';

import '../widgets/build_personal_card.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  List<String> myItemNames = [];
  List<String> myItemImages = [];
  List<String> wishListNames = [];
  List<String> wishListImages = [];

  @override
  void initState() {
    super.initState();
    //placeholders
    myItemNames = List.generate(3, (index) => 'Loading...');
    myItemImages = List.generate(3, (index) => loadingBase64);
    wishListNames = List.generate(3, (index) => 'Loading...');
    wishListImages = List.generate(3, (index) => loadingBase64);
    // 在初始化时从数据库获取物品名称、图片、品牌名和颜色
    fetchItemInfoPersonal();
  }

  Future<void> fetchItemInfoPersonal() async {
    // 获取当前用户的email
    String currentUserEmail = (await getUserEmail()) ?? ''; // 使用空字串作為默認值
    List<String> names = await DatabaseHelper().fetchItemNames();
    List<String> images = await DatabaseHelper().fetchItemImages();
    List<String> owners = await DatabaseHelper().fetchItemOwner();

    // 過濾"我的物品"
    List<int> myItemIndices = List.generate(owners.length, (index) => index)
        .where((index) => owners[index] == currentUserEmail)
        .toList();

    // 過濾"願望物品"
    List<int> wishListIndices = List.generate(owners.length, (index) => index)
        .where((index) => owners[index] != currentUserEmail)
        .toList();

    if (mounted) {
      setState(() {
        myItemNames = myItemIndices.map((index) => names[index]).toList();
        myItemImages = myItemIndices.map((index) => images[index]).toList();
        wishListNames = wishListIndices.map((index) => names[index]).toList();
        wishListImages = wishListIndices.map((index) => images[index]).toList();
      });
    }
  }

  void _showNotification(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('This is notification'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //底色
        Expanded(
          child: Container(
            //width: 390,
            width: SizeConfig.screenWidth,
            //height: 722,
            height: SizeConfig.screenHeight,
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
              //圖層2(Icon)
              children: [
                Positioned(
                  top: 80, // 调整垂直位置
                  left: 30, // 调整水平位置
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FutureBuilder<String?>(
                      future: getUserEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            'Hi, ${snapshot.data ?? 'User Email'}',
                            style: const TextStyle(
                              color: Color(0xFF151515),
                              fontSize: 16,
                              fontFamily: 'Basic',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.80,
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 65,
                  right: 30,
                  child: IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.doorbell_outlined),
                    onPressed: () {
                      _showNotification(context);
                    },
                  ),
                ),
                //白色區域
                Container(
                    //width: 389,
                    width: SizeConfig.screenWidth,
                    //height: 575,
                    //height = screeenheight -147
                    height: SizeConfig.screenHeight,
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
                          padding:
                              EdgeInsets.only(top: 40, left: 30, bottom: 30),
                          child: Text(
                            'My items',
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
                            children: myItemNames.map((itemName) {
                              String imageBase64 =
                                  myItemImages[myItemNames.indexOf(itemName)];

                              return buildItemCard(
                                itemName: itemName,
                                imageBase64: imageBase64,
                              );
                            }).toList(),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 40, left: 30, bottom: 30),
                          child: Text(
                            'Wishlist',
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
                            children:
                                wishListNames.asMap().entries.map((entry) {
                              int index = entry.key;
                              String itemName = entry.value;
                              String imageBase64 = wishListImages[index];

                              return buildItemCard(
                                itemName: itemName,
                                imageBase64: imageBase64,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
