import 'package:flutter/material.dart';
import 'package:swap/screens/success_page.dart';
import 'package:swap/size_config.dart';
import 'package:swap/widgets/build_request_card.dart';

class ExchangeRequestPage extends StatelessWidget {
  final String itemName;
  final Image decodedImage;

  const ExchangeRequestPage({
    Key? key,
    required this.itemName,
    required this.decodedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double imageWidth = getProportionateScreenWidth(200);
    double imageHeight = getProportionateScreenHeight(200);

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
                      'Exchange requests',
                      style: TextStyle(
                        color: Color(0xFF151515),
                        fontSize: 24,
                        fontFamily: 'Basic',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.80,
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
                          const SizedBox(
                            height: 100,
                          ),
                          /*
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return RequestCard(
                                itemName: 'itemName$index',
                                ownerName: 'ownerName$index',
                                expirationDate: '$index',
                                imageProvider:
                                    const AssetImage('assets/images/dog.jpeg'),
                                onAccept: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SuccessPage(),
                                    ),
                                  );
                                },
                                onReject: () {},
                              );
                            },
                          ),
                          */
                          //demo用
                          const VerticalSpacing(
                            of: 40,
                          ),
                          RequestCard(
                              ownerName: 'demo1@xxxx.edu.tw',
                              itemName: 'mouse',
                              expirationDate: '4',
                              imageProvider:
                                  const AssetImage('assets/images/mouse.jpg'),
                              onAccept: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SuccessPage(),
                                  ),
                                );
                              },
                              onReject: () {}),
                          RequestCard(
                              ownerName: 'demo2@xxxx.edu.tw',
                              itemName: 'teddy bear',
                              expirationDate: '2',
                              imageProvider: const AssetImage(
                                  'assets/images/teddybear.jpg'),
                              onAccept: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SuccessPage(),
                                  ),
                                );
                              },
                              onReject: () {}),
                          RequestCard(
                              ownerName: 'demo3@xxxx.edu.tw',
                              itemName: 'backpack',
                              expirationDate: '5',
                              imageProvider: const AssetImage(
                                  'assets/images/backpack.jpg'),
                              onAccept: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SuccessPage(),
                                  ),
                                );
                              },
                              onReject: () {}),
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
                          )),
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
