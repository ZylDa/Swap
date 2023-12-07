import 'package:flutter/material.dart';
import 'package:swap/color_constants.dart';
import 'package:swap/size_config.dart';
import 'package:swap/widgets/wishlist_info.dart';

class WishlistPage extends StatelessWidget {
  final String itemName;
  final Image decodedImage;
  final String ownerName;
  final List<String> tags;
  final String requestTime;

  const WishlistPage(
      {super.key,
      required this.itemName,
      required this.decodedImage,
      required this.ownerName,
      required this.tags,
      required this.requestTime});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double imageWidth = getProportionateScreenWidth(200);
    double imageHeight = getProportionateScreenHeight(200);

    double buttonWidth = getProportionateScreenWidth(315);
    double buttonHeight = getProportionateScreenHeight(55);

    double topImagePosition = getProportionateScreenHeight(203 - 40);
    double topWhitePosition = getProportionateScreenHeight(844 - 567 - 40);

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                color: Color(0xFFE9E8DB),
                shape: RoundedRectangleBorder(side: BorderSide(width: 0)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 15,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Positioned(
                    top: 105,
                    left: 30,
                    child: Text(
                      'You requested...',
                      style: TextStyle(
                        color: Color(0xFF151515),
                        fontSize: 24,
                        fontFamily: 'Basic',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
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
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          const VerticalSpacing(
                            of: 70,
                          ),
                          WishlistInfo(
                              itemName: itemName,
                              ownerName: ownerName,
                              tags: tags,
                              requestTime: requestTime),
                          const VerticalSpacing(
                            of: 100,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'You have canceled the request successfully.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(buttonWidth, buttonHeight), // 設置寬度和高度
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              backgroundColor: kButtonColor,
                              shadowColor:
                                  Colors.black.withOpacity(0.5), // 陰影顏色和透明度
                              elevation: 5, // 陰影高度
                            ),
                            child: const Text(
                              'Cancel Request',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: topImagePosition,
                    left: (SizeConfig.screenWidth ?? 0) / 2 - 100,
                    child: Container(
                      width: imageWidth,
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: decodedImage.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
