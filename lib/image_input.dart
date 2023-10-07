import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap/navigation.dart';
import 'mongodb/mongodb.dart';
import 'mongodb/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
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
    super.initState();
    _takePicture(); // Automatically launch the camera on widget initialization
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

     _insertImg();

    if (widget.onPictureTaken != null) {
      widget.onPictureTaken(_selectedImage!);
      //Navigator.pop(context); // Navigate back to previous screen after taking the photo
    }
    //Navigator.pop(context, _selectedImage);
  }

  Future<void> _insertImg() async {
    if (_selectedImage == null) {
      return;
    }
    String currentUserEmail = (await getUserEmail()) ?? ''; // 使用空字串作為默認值
    final bytes = await _selectedImage!.readAsBytes();
    final base64Image = base64Encode(bytes);   
    final uuid = const Uuid().v4(); // 生成一個新的UUID
    final data = MongoDbModel(
        id: uuid, owner: currentUserEmail, name: "", tag: [], image: base64Image);
    var result = await MongoDatabase.insert(data);
    print('result在下面');
    print('result:  $result');
    widget.onInsertId(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 350,
      width: double.infinity,
      alignment: Alignment.center,
      child: _selectedImage != null
          ? GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : const CircularProgressIndicator(), // Show a loading indicator while capturing the image
    );
  }
}
