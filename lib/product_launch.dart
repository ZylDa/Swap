import 'dart:io';
import 'package:flutter/material.dart';
import 'mongodb/mongodb.dart';
import 'navigation.dart';
import './components/tag_text_field.dart';
import 'image_input.dart';

class ProductLaunch extends StatefulWidget {
  final File? capturedImage;
  final String? id;
  final String? itemName;
  final List? tags;
  const ProductLaunch(
      {super.key, this.capturedImage, this.id, this.itemName, this.tags});

  @override
  State<ProductLaunch> createState() {
    return _ProductLaunchState();
  }
}

class _ProductLaunchState extends State<ProductLaunch> {
  final nameController = TextEditingController();
  final tag1Controller = TextEditingController();
  final tag2Controller = TextEditingController();
  final tag3Controller = TextEditingController();
  final tag4Controller = TextEditingController();
  final tag5Controller = TextEditingController();

  //List<String> tags = [];

  @override
  void initState() {
    //MongoDatabase.changeStreamOG();
    //MongoDatabase.changeStreamForSpecificId('1');

    if (widget.capturedImage != null) {
      _productImage = widget.capturedImage!;
    }
    if (widget.id != null) {
      id = widget.id!;
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
  String? id;
  

  @override
  Widget build(BuildContext context) {
    if (widget.tags != null && widget.tags!.isNotEmpty && widget.tags![0] != null) {
    tag1Controller.text = widget.tags![0]!;
  } else {
    tag1Controller.text = 'Black';
  }

    if (widget.tags != null && widget.tags!.isNotEmpty && widget.tags![1] != null) {
      tag2Controller.text = widget.tags![1];
    } else {
      tag2Controller.text = 'Exercise';
    }
    if (widget.tags != null && widget.tags!.isNotEmpty && widget.tags![2] != null) {
      tag3Controller.text = widget.tags![2];
    } else {
      tag3Controller.text = 'Plastic';
    }
    

    // tag1Controller.text = 'Black';
    // tag2Controller.text = 'Exercise';
    // tag3Controller.text = 'Plastic';
    // tag4Controller.text = 'WatterBottle';

    // tags = [
    //   tag1Controller.text,
    //   tag2Controller.text,
    //   tag3Controller.text,
    //   tag4Controller.text,
    //   tag5Controller.text
    // ];

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
                      'List & Swap',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Item',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController
                        ..text = widget.itemName ?? "Water Bottle",
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
                      'Tags',
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
                      'Photos',
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
                      _productImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _productImage!,
                                width: 300,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/glass.png',
                                width: 300,
                              ),
                            ),
                      const SizedBox(width: 50),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageInput(
                                  onPictureTaken: (image) {
                                    Navigator.pop(
                                        context); // Close ImageInput after taking photo
                                    setState(() {
                                      _productImage = image;
                                    });
                                  },
                                  onInsertId: (id) {}),
                            ),
                          );
                        },
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
                    _updateData(id!, nameController.text, [
                      tag1Controller.text,
                      tag2Controller.text,
                      tag3Controller.text,
                      tag4Controller.text,
                      tag5Controller.text
                    ]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigation()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 135,
                    ),
                    backgroundColor: const Color.fromARGB(255, 196, 194, 178),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    'List',
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

  Future<void> _updateData(String id, String name, List<String> tags) async {
    //var _id = M.ObjectId(); //use for unique ID
    //final data = MongoDbModel(id:id, owner: owner, name: name, tag: tag, image: []);
    var result = await MongoDatabase.update(id, name, tags);
    if (result == null) {
      print('上架成功');
    }
    print('id: $id');
    //print('result: $result');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Center(child: Text('上架成功')),
      ),
    );
  }
}
