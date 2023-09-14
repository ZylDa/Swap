import 'dart:io';
import 'package:flutter/material.dart';
import 'mongodb/mongodb_model.dart';
import 'mongodb/mongodb.dart';
import 'components/tag_text_field.dart';

class ProductLaunch extends StatefulWidget {
  final File? capturedImage;
  const ProductLaunch({super.key, this.capturedImage});

  @override
  State<ProductLaunch> createState() {
    return _ProductLaunchState(); //有機會
  }
}

class _ProductLaunchState extends State<ProductLaunch> {
  final nameController = TextEditingController();
  final tag1Controller = TextEditingController();
  final tag2Controller = TextEditingController();
  final tag3Controller = TextEditingController();
  final tag4Controller = TextEditingController();
  final tag5Controller = TextEditingController();
  //File? _productImage;

  List<String> tags = [];

  @override
  void initState() {
    if (widget.capturedImage != null) {
      _productImage = widget.capturedImage!;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    tag1Controller.dispose();
    tag2Controller.dispose();
    tag3Controller.dispose();
    tag4Controller.dispose();
    tag5Controller.dispose();
    super.dispose();
  }

  File? _productImage;

  @override
  Widget build(BuildContext context) {
    tag1Controller.text = '藍色';
    tag2Controller.text = 'nike';
    tag3Controller.text = '生活用品';
    tag4Controller.text = '白色';
    tags = [
      tag1Controller.text,
      tag2Controller.text,
      tag3Controller.text,
      tag4Controller.text,
      tag5Controller.text
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false, // fix the keyboard resize screen issue
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      '你有料嗎？',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '商品名稱',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController..text = "環保杯",
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                        //labelText: '商品名稱',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(99, 177, 172, 172),
                      ),
                      cursorColor: Colors.black,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Hashtag',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        // ...['tag1', 'tag2', 'tag3'].map(
                        //   (tag) {
                        //     return TagTextField(tag);
                        //   },
                        // )
                        TagTextField(controller: tag1Controller),
                        TagTextField(controller: tag2Controller),
                        TagTextField(controller: tag3Controller),
                        TagTextField(controller: tag4Controller),
                        TagTextField(controller: tag5Controller),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '商品照片',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _productImage != null
                            ? Image.file(
                                _productImage!,
                                width: 300,
                              )
                            : Image.asset(
                                'assets/images/glass.png',
                                width: 300,
                              ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text(""),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 150),
                          backgroundColor:
                              const Color.fromARGB(255, 206, 206, 206),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //tags.add(TagTextField.getTagController());
                    _insertData(nameController.text, tags);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    backgroundColor: const Color.fromRGBO(7, 69, 60, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    '上架',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(String name, List<String> tag) async {
    //var _id = M.ObjectId(); //use foe unique ID
    final data = MongodbModel(name: name, tag: tag);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Center(child: Text('上架成功')),
      ),
    );
  }
}
