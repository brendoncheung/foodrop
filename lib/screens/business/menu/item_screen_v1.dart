import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/custom_colors.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/business/common_widgets/show_alert_dialog.dart';
import 'package:foodrop/screens/business/menu/category_selection_screen.dart';
import 'package:foodrop/screens/business/menu/show_selected_images.dart';
import 'package:foodrop/screens/common_widgets/camera_multi_image_picker.dart';
import 'package:provider/provider.dart';

class ItemScreenV1 extends StatefulWidget {
  ItemScreenV1({this.userId, this.item, this.db, this.businessId, this.categories, this.businessAvatarUrl});
  Database db;
  Item item;
  String businessId;
  List<ItemsCategory> categories;
  String userId;
  String businessAvatarUrl;

  @override
  _ItemScreenV1State createState() => _ItemScreenV1State();
}

class _ItemScreenV1State extends State<ItemScreenV1> {
  final _itemFormKey = GlobalKey<FormState>();

  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  TextEditingController _tecDescription = TextEditingController();
  TextEditingController _tecCategory = TextEditingController();

  bool _formSubmittedBefore = false;
  // bool _capturedNewImage = false;
  // File _imageFile;

  bool _showEnlargedImage = false;
  int _selectedImageIndexToEnlarge = 0;

  // bool _isCreatingNewItem = true;
  bool _thereAreNoItemImages = true;

  // Item get _item => widget.item;
  Item _item = new Item(photoUrlList: []);
  Database get _db => widget.db;
  // Item cuItem = Item();

  Color _photoTextColor;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.item != null) {
      _item = widget.item;
      _tecName.text = _item.name;
      _tecPrice.text = _item.price.toString();
      _tecDescription.text = _item.description;
      // _isCreatingNewItem = false;
      _tecCategory.text = _item.categoryName;
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tecName.dispose();
    _tecPrice.dispose();
    _tecDescription.dispose();
    _tecCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final _user = Provider.of<UserProfile>(context, listen: false);
    if (_item.photoUrlList != null) {
      _thereAreNoItemImages = _item.photoUrlList.length > 0 ? false : true;
      _photoTextColor = _item.photoUrlList.length == 0 && _formSubmittedBefore ? Colors.red : Colors.black54;
    }

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
        // onTap: () => print("show album"),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
          child: CameraMultiImagePicker(
            getImages: (List<File> file) => {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ShowSelectedImages(
                          selectedImageFiles: file,
                          businessId: widget.businessId,
                          db: _db,
                          newImageUrls: (listOfUrls) => _addToCurrentUrls(listOfUrls),
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
              _thereAreNoItemImages // if true => show Placeholder widget
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Placeholder(
                            fallbackHeight: MediaQuery.of(context).size.height / 5,
                          ),
                        ),
                        Center(
                          child: Container(
                              child: Text(
                            "Add some photos",
                            style: TextStyle(color: _photoTextColor),
                          )),
                        )
                      ],
                    )
                  : _buildListViewPhotoUrls(),
              _buildForm(),
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
    final selectDeleteImage = await showAlertDialog(context, title: "Deleting Image", content: "Are you sure", defaultActionText: "Delete", cancelActionText: "Cancel");

    if (selectDeleteImage) {
      setState(() {
        _item.photoUrlList.removeAt(index);
      });

      print("Delete index: $index");
    }
  }

  _enlargePic(int index) {
    setState(() {
      _showEnlargedImage = true;
      _selectedImageIndexToEnlarge = index;
    });
  }

  _addToCurrentUrls(List<String> listOfUrls) {
    if (_item.photoUrlList == null) {
      _item.photoUrlList = [];
    }
    for (String url in listOfUrls) {
      _item.photoUrlList.add(url);
      print("adding =====> $url");
    }
    setState(() {});
  }

  _buildForm() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Form(
          key: _itemFormKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    onSaved: (text) => _item.name = text,
                    controller: _tecName,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (text) {
                      if ((text.isEmpty || text == null) && _formSubmittedBefore) {
                        return "Cannot be empty";
                      } else {
                        return null;
                      }
                    }
                    // onChanged: (text) => widget.item.name = text,
                    ),
                TextFormField(
                    onSaved: (text) => _item.price = double.tryParse(text),
                    controller: _tecPrice,
                    decoration: InputDecoration(labelText: "Price"),
                    validator: (price) {
                      if (double.tryParse(price) != null && _formSubmittedBefore) {
                        return null;
                      } else {
                        return "this is an invalid entry";
                      }
                    }),
                Stack(
                  children: [
                    TextFormField(
                      controller: _tecCategory,
                      validator: (text) {
                        if (_formSubmittedBefore && text.length == 0) {
                          return "Please select category";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                      decoration: InputDecoration(labelText: "Category: ${_item.categoryName}"),
                    ),
                    ListTile(
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Provider<List<ItemsCategory>>(
                              create: (context) => widget.categories,
                              child: Consumer<List<ItemsCategory>>(
                                builder: (_, categories, __) => CategorySelectionScreen(
                                    categories: categories,
                                    defaultCategoryName: _item.categoryName == "" ? null : _item.categoryName,
                                    onSelectedCategory: (selectedCategory) {
                                      setState(() {
                                        _item.categoryName = selectedCategory.name;
                                        _item.categoryId = selectedCategory.docId;
                                        _tecCategory.text = _item.categoryName;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                // Divider(
                //   thickness: 2,
                // ),
                TextFormField(
                  // onChanged: (text) => widget.item.description = text,
                  onSaved: (text) => _item.description = text,
                  controller: _tecDescription,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: "Description (optional)",
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _onSaveAndClose(context: context),
                  child: Text("Save and Close!"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onSaveAndClose({BuildContext context}) async {
    setState(() {
      _formSubmittedBefore = true;
    });

    _item.businessId = widget.businessId;
    _item.lastUpdateByUserId = widget.userId;
    _item.businessAvatarUrl = widget.businessAvatarUrl;

    if (_itemFormKey.currentState.validate()) {
      _itemFormKey.currentState.save();
      await widget.db.setItem(item: _item);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error countered'),
        ),
      );
    }

    // try {
    //   if (_capturedNewImage) {
    //     final urlString = await widget.db.setImage(
    //       pickedImage: File(_imageFile.path),
    //       docId: Utilities.documentIdFromCurrentDate(),
    //       storageCollectionName:
    //       APIPath.menuImageStoragePath(businessId: widget.businessId),
    //     );
    //     _item.photoUrl = urlString;
    //     _item.businessId = widget.businessId ?? _item.businessId;
    //   }
    //
    //   await widget.db.setItem(item: _item);
    // } on FirebaseException catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(e.message),
    //   ));
    // }
  }
}
