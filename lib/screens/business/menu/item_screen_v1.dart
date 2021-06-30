import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/services/custom_colors.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/business/common_widgets/show_alert_dialog.dart';
import 'package:foodrop/screens/business/menu/show_selected_images.dart';
import 'package:foodrop/screens/common_widgets/camera_multi_image_picker.dart';

class ItemScreenV1 extends StatefulWidget {
  ItemScreenV1({@required this.item, this.db, this.businessId});
  Database db;
  Item item;
  String businessId;

  @override
  _ItemScreenV1State createState() => _ItemScreenV1State();
}

class _ItemScreenV1State extends State<ItemScreenV1> {
  final _menuItemFormKey = GlobalKey<FormState>();

  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  TextEditingController _tecDescription = TextEditingController();
  TextEditingController _tecCategory = TextEditingController();

  bool _formSubmittedBefore = false;
  bool _capturedNewImage = false;
  File _imageFile;

  bool _showEnlargedImage = false;
  int _selectedImageIndexToEnlarge = 0;

  Item get _item => widget.item;
  Database get _db => widget.db;

  @override
  void initState() {
    // TODO: implement initState
    if (_item != null) {
      _tecName.text = _item.name;
      _tecPrice.text = _item.price.toString();
      _tecDescription.text = _item.description;
      setState(() {});
    } else {
      widget.item = Item();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tecName.dispose();
    _tecPrice.dispose();
    _tecDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final imageWidget = _item == null || _item.photoUrlList == ""
    //     ? Container(
    //   width: double.infinity,
    //   height: MediaQuery.of(context).size.height / 5,
    //   child: CameraImagePicker(
    //     getImage: (imageFile) => setState(
    //           () {
    //         _item.photoUrlList = imageFile.path;
    //         _capturedNewImage = true;
    //         _imageFile = imageFile;
    //       },
    //     ),
    //   ),
    // )
    //     : _capturedNewImage
    //     ? Image.file(
    //   _imageFile,
    //   fit: BoxFit.cover,
    // )
    //     : Image.network(
    //   _item.photoUrlList,
    //   fit: BoxFit.cover,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("${_item.name}"),
        backgroundColor: CustomColors.vendorAppBarColor,
        actions: [
          _buildCameraActionIcon(),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Padding _buildCameraActionIcon() {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => print("show album"),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
          child: CameraMultiImagePicker(
            getImages: (List<File> file) => {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ShowSelectedImages(
                          selectedImageFiles: file,
                          businessId: widget.businessId
                        ),
                    fullscreenDialog: true),
              )
            },
          ),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    // final _db = Provider.of<Database>(context, listen: false);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              _buildListViewPhotoUrls(),
            ],
          ),
          if (_showEnlargedImage) _showEnlargedImageContainer(context)
        ],
      ),
    );
  }

  InkWell _showEnlargedImageContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _showEnlargedImage = false;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3 * 2,
        // color: Colors.red,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400,
                maxWidth: 400,
              ),
              child: Image.network(
                _item.photoUrlList[_selectedImageIndexToEnlarge],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildListViewPhotoUrls() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _item.photoUrlList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              InkWell(
                onTap: () => _enlargePic(index),
                child: Card(
                  child: Wrap(
                    children: [
                      Image.network(
                        _item.photoUrlList[index],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  iconSize: 50,
                  onPressed: () => _toDeleteImage(index))
            ],
          );
        },
      ),
    );
  }

  _toDeleteImage(int index) async {
    final selectDeleteImage = await showAlertDialog(context,
        title: "Deleting Image",
        content: "Are you sure",
        defaultActionText: "Delete",
        cancelActionText: "Cancel");

    if (selectDeleteImage) {
      // if confirmDelete
      print("Delete index: $index");
    }
  }

  _enlargePic(int index) {
    setState(() {
      _showEnlargedImage = true;
      _selectedImageIndexToEnlarge = index;
    });
  }

  // return Container(
  // width: 400,
  // height: 100,
  // child: ListView.builder(
  // scrollDirection: Axis.horizontal,
  // shrinkWrap: true,
  // itemCount: item.photoUrlList.length + 1,
  // itemBuilder: (context, index) {
  // if (index == item.photoUrlList.length) {
  // return CircleAvatar(
  // backgroundColor: Colors.grey,
  // radius: 50,
  // child: Icon(
  // Icons.photo_camera,
  // color: Colors.black,
  // ),
  // );
  // }
  // return Card(
  // child: Wrap(
  // children: [
  // Image.network(
  // item.photoUrlList[index],
  // height: 100,
  // width: 100,
  // fit: BoxFit.cover,
  // ),
  // ],
  // ),
  // );
  // },
  // ),
  // );
// },
// ),
// );

//   _buildBody() {
//     final _db = Provider.of<Database>(context, listen: false);
//     SingleChildScrollView(
//         child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 700,
//             child: StreamBuilder(
//                 stream: _db.itemsStream(),
//                 builder: (context, snapshot) {
// switch (snapshot.connectionState) {
// // case ConnectionState.waiting:
// // {
// // return Center(child: CircularProgressIndicator());
// // }
// // break;
// // case ConnectionState.active:
// // {
// // return Container(
// // child: AsyncSnapshotItemBuilder<Item>(
// // withDivider: true,
// // snapshot: snapshot,
// // itemBuilder: (context, item) {
// // return Container(
// // width: 400,
// // height: 110,
// // // color: Colors.blue,
// // child: ListView.builder(
// // scrollDirection: Axis.horizontal,
// // shrinkWrap: true,
// // itemCount: item.photoUrlList.length + 1,
// // itemBuilder: (context, index) {
// // if (index == item.photoUrlList.length) {
// // return CircleAvatar(
// // backgroundColor: Colors.grey,
// // radius: 50,
// // // height: 100,
// // // width: 100,
// // child: Icon(
// // Icons.photo_camera,
// // color: Colors.black,
// // ),
// // );
// // }
// // return Card(
// // child: Wrap(
// // children: [
// // Image.network(
// // item.photoUrlList[index],
// // height: 100,
// // width: 100,
// // fit: BoxFit.cover,
// // ),
// // ],
// // ),
// // );
// // },
// // ),
// // );
// // },
// // ),
// // );
// // }
// // break;
// // default:
// // {
// // return CircularProgressIndicator();
// //     }
//
//                 })));
//   }
}
