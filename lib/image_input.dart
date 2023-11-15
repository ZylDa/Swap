import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap/navigation.dart';
import 'mongodb/mongodb.dart';
import 'mongodb/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;
import 'package:uuid/uuid.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onPictureTaken;
  final Function(String id) onInsertId;
  const ImageInput({
    super.key,
    required this.onPictureTaken,
    required this.onInsertId,
  });

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  @override
  void initState() {
    //MongoDatabase.changeStreamOG('1');
    super.initState();
    _takePicture(); // Automatically launch the camera on widget initialization
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Navigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; //沒有任何滑動
          },
        ),
      );
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    _insertImg();

    widget.onPictureTaken(_selectedImage!);
    //Navigator.pop(context, _selectedImage);
  }

  Future<void> _insertImg() async {
    if (_selectedImage == null) {
      return;
    }
    final String currentUserEmail = (await getUserEmail()) ?? ''; // 使用空字串作為默認值
    final bytes = await _selectedImage!.readAsBytes();
    //final base64Image = base64Encode(bytes);
    Uint8List binaryImageData = Uint8List.fromList(bytes);
    final bsonBinary = BsonBinary.from(binaryImageData);

    final uuid = const Uuid().v4(); // 生成一個新的UUID
    final data = MongoDbModel(
        id: uuid,
        owner: currentUserEmail,
        name: "",
        tag: [],
        binary: bsonBinary);
    var result = await MongoDatabase.insert(data);
    print('insert result:  $result');
    widget.onInsertId(uuid);
    //MongoDatabase.changeStreamOG(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          // 首先添加图片
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          //然后添加完全不透明的灰色遮罩
          if (_selectedImage != null)
            Container(
              color: Colors.black.withOpacity(0.7), // 半透明灰色遮罩
              width: double.infinity,
              height: double.infinity,
            ),
          // 最后添加加载指示器
          if (_selectedImage != null)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
