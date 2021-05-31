import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeTileWidget extends StatelessWidget {
  Image _image;
  String _title;
  String _description;

  HomeTileWidget(Image image, String title, String description)
      : _image = image,
        _title = title,
        _description = description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      child: Column(
        children: [
          Container(
            child: Image.network(
              "https://picsum.photos/200/600",
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "akjshdlkashdlkhakslhdlkj",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
