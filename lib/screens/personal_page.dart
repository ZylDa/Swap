import 'package:flutter/material.dart';
import 'package:swap/mongodb/database_helper.dart';
import 'package:swap/navigation.dart';
import 'package:swap/screens/exchange_request_page.dart';
import 'package:swap/size_config.dart';
import 'package:swap/components/loading.dart';
import 'package:swap/mongo_auth/login_page.dart';
import '../notification.dart';

import '../widgets/build_item_card.dart';

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

  void _showSettingsMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0), // 設定菜單位置
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text('交換紀錄'),
            onTap: () {
              // 在這裡執行交換紀錄的操作
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.mail),
            title: const Text('聯絡我們'),
            onTap: () {
              // 在這裡執行聯絡我們的操作
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('登出'),
            onTap: () async {
              LoginPage.logout(context);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              //圖層2(Icon)
              children: [
                Positioned(
                  top: 80,
                  left: 30,
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
                  top: 72,
                  right: 70,
                  child: IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.notifications),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return NotificationWidget();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 72,
                  right: 15,
                  child: IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.settings),
                    color: Colors.black,
                    onPressed: () {
                      _showSettingsMenu(context);
                    },
                  ),
                ),
                //白色區域
                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    margin: const EdgeInsets.only(top: 147),
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
                                onTap: () {
                                  // 在這裡導航到交換申請頁面
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExchangeRequestPage(
                                          itemName: itemName),
                                    ),
                                  );
                                },
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
                                onTap: () {
                                  // 在這裡導航到交換申請頁面
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExchangeRequestPage(
                                          itemName: itemName),
                                    ),
                                  );
                                },
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
