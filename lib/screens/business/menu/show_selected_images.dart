import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/services/database/api_path.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:provider/provider.dart';

class ShowSelectedImages extends StatefulWidget {
  ShowSelectedImages(
      {@required this.selectedImageFiles,
      @required this.businessId,
      @required this.db,
      @required this.newImageUrls});
  List<File> selectedImageFiles;
  String businessId;
  Database db;
  Function(List<String>) newImageUrls;

  @override
  _ShowSelectedImagesState createState() => _ShowSelectedImagesState();
}

class _ShowSelectedImagesState extends State<ShowSelectedImages> {
  List<String> listOfUrls = [];
  bool isAddingFileToCloud = false;

  @override
  Widget build(BuildContext context) {
    // final db = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Images"),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isAddingFileToCloud = true;
              });
              listOfUrls = await widget.db.setImages(
                  imageFiles: widget.selectedImageFiles,
                  apiPath: APIPath.menuImageStoragePath(
                      businessId: widget.businessId));
              setState(() {
                isAddingFileToCloud = false;
              });
              widget.newImageUrls(listOfUrls);

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: Container(
        width: 500,
        height: 500,
        child: isAddingFileToCloud
            ? CircularProgressIndicator()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.selectedImageFiles.length,
                itemBuilder: (context, index) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      // maxWidth: 250,
                    ),
                    child: Image.file(
                      widget.selectedImageFiles[index],
                      fit: BoxFit.cover,
                    ),
                  );
                }),
      ),
    );
  }
}
