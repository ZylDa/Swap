import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onPictureTaken;
  const ImageInput({super.key, required this.onPictureTaken});

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

    if (widget.onPictureTaken != null) {
      widget.onPictureTaken(_selectedImage!);
      //Navigator.pop(context); // Navigate back to previous screen after taking the photo
    }
    //Navigator.pop(context, _selectedImage);
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
