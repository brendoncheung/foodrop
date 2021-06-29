import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraMultiImagePicker extends StatefulWidget {
  CameraMultiImagePicker({this.getImages});
  Function(List<File>) getImages;

  @override
  _CameraMultiImagePickerState createState() => _CameraMultiImagePickerState();
}

class _CameraMultiImagePickerState extends State<CameraMultiImagePicker> {
  final imagePicker = ImagePicker();
  List<File> _selectedImageFiles;

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
    final pickedImageFile = await imagePicker.getMultiImage(
        // source: ImageSource.gallery,
        // imageQuality: 50,
        // maxWidth: 300,
        // maxHeight: 500,
        );

    if (pickedImageFile != null) {
      print(pickedImageFile);
      _selectedImageFiles =
          pickedImageFile.map((img) => File(img.path)).toList();
      widget.getImages(_selectedImageFiles);
      // _selectedImages = File(pickedImageFile.path);
      // widget.getImage(_selectedImages);
    } else {
      print("no image selected");
      // widget.getImage(null);
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
