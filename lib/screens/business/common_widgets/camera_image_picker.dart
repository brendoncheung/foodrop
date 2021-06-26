import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraImagePicker extends StatefulWidget {
  CameraImagePicker({this.getImage});
  Function(File) getImage;

  @override
  _CameraImagePickerState createState() => _CameraImagePickerState();
}

class _CameraImagePickerState extends State<CameraImagePicker> {
  final imagePicker = ImagePicker();
  File _selectedImage;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.photo_camera),
        onPressed: selectImage,
      ),
    );
  }

  Future<void> selectImage() async {
    final pickedImageFile = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 700,
    );

    if (pickedImageFile != null) {
      _selectedImage = File(pickedImageFile.path);
      widget.getImage(_selectedImage);
    } else {
      print("no image selected");
      widget.getImage(null);
    }
  }
}

//
// Future<void> _pickImage() async {
//   final pickedImage = await picker.getImage(
//     source: ImageSource.gallery,
//     imageQuality: 50,
//     maxWidth: 150,
//   );
//
//   if (pickedImage != null) {
//     setState(() {
//       _pickedImage = File(pickedImage.path);
//     });
//   } else {
//     print("No image selected");
//   }
// }
