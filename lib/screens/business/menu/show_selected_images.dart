import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:provider/provider.dart';

class ShowSelectedImages extends StatelessWidget {
  ShowSelectedImages({this.selectedImageFiles, this.businessId});
  List<File> selectedImageFiles;
  String businessId;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Images"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: Container(
        width: 500,
        height: 500,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: selectedImageFiles.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 100,
                  // maxWidth: 250,
                ),
                child: Image.file(
                  selectedImageFiles[index],
                  fit: BoxFit.cover,
                ),
              );
            }),
      ),
    );
  }
}
