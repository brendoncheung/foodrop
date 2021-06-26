<<<<<<< HEAD
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/api_path.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/core/services/utilities.dart';
import 'package:foodrop/screens/business/menu/category_selection_screen.dart';
import 'package:foodrop/screens/common_widgets/camera_image_picker.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({this.businessId, this.db, this.item, this.categories});
  final String businessId;
  Item item;
  final Database db;
  final List<ItemsCategory> categories;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final _menuItemFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if (item != null) {
      _tecName.text = item.name;
      _tecPrice.text = item.price.toString();
      _tecDescription.text = item.description;
      setState(() {});
    } else {
      widget.item = Item();
    }
    super.initState();
  }

  Item get item => widget.item;
  TextEditingController _tecName = TextEditingController();
  TextEditingController _tecPrice = TextEditingController();
  TextEditingController _tecDescription = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _tecName.dispose();
    _tecPrice.dispose();
    _tecDescription.dispose();

    super.dispose();
  }

  Item get _item => widget.item;

  bool imageIsFileType = false;
  File _imageFile;
  @override
  Widget build(BuildContext context) {
    // final _business = Provider.of<Database>(context, listen: false);
    final size = MediaQuery.of(context).size;

    final imageWidget = _item == null || _item.photoUrl == ""
        ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
            // child: IconButton(
            //   icon: Icon(
            //     Icons.photo_camera,
            //     size: 40,
            //   ),
            //   onPressed: () {},
            // ),
            child: CameraImagePicker(
              getImage: (imageFile) => setState(
                () {
                  // print("xxx ${imageFile.path.toString()} xxx");

                  _item.photoUrl = imageFile.path;
                  imageIsFileType = true;
                  _imageFile = imageFile;
                },
              ),
            ),
          )
        : imageIsFileType
            ? Image.file(
                _imageFile,
                fit: BoxFit.cover,
              )
            : Image.network(_item.photoUrl);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.item.name),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(width: double.infinity, child: imageWidget),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height / 15, left: 10, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.chevron_left,
                            size: 48,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _menuItemFormKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onSaved: (text) => _item.name = text,
                      controller: _tecName,
                      decoration: InputDecoration(labelText: "Name"),
                      // onChanged: (text) => widget.item.name = text,
                    ),
                    TextFormField(
                      onSaved: (text) => _item.price = double.tryParse(text),
                      controller: _tecPrice,
                      decoration: InputDecoration(labelText: "Price"),
                      // onChanged: (text) =>
                      //     widget.item.price = double.tryParse(text),
                    ),
                    ListTile(
                      title: Align(
                        alignment: Alignment(-1.17, 0.0),
                        child: _item == null
                            ? Text("Category:")
                            : Text("Category: ${_item.categoryName}"),
                      ),
                      // subtitle: Text(widget.item.categoryName),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Provider<List<ItemsCategory>>(
                              create: (context) => widget.categories,
                              child: Consumer<List<ItemsCategory>>(
                                builder: (_, categories, __) =>
                                    CategorySelectionScreen(
                                        categories: categories,
                                        defaultCategoryName:
                                            _item.categoryName == ""
                                                ? null
                                                : _item.categoryName,
                                        onSelectedCategory: (selectedCategory) {
                                          setState(() {
                                            _item.categoryName =
                                                selectedCategory.name;
                                            _item.categoryId =
                                                selectedCategory.docId;
                                          });
                                        }),
                              ),
                            ),
                          ),
                        );
                      },
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    TextFormField(
                      // onChanged: (text) => widget.item.description = text,
                      onSaved: (text) => _item.description = text,
                      controller: _tecDescription,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _onSaveAndClose,
                      child: Text("Save and Close!"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSaveAndClose() async {
    try {
      _menuItemFormKey.currentState.save();
      final urlString = await widget.db.setImage(
        pickedImage: File(_imageFile.path),
        docId: Utilities.documentIdFromCurrentDate(),
        storageCollectionName:
            APIPath.menuImageStoragePath(businessId: widget.businessId),
      );
      _item.photoUrl = urlString;
      _item.businessId = widget.businessId;
      widget.db.setItem(item: _item);
    } catch (e) {
      print("somethign is wrong");
    }

    Navigator.of(context).pop();
  }
}
=======
// import 'dart:ffi';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:foodrop/core/models/item.dart';
// import 'package:foodrop/core/models/items_category.dart';
// import 'package:foodrop/core/services/api_path.dart';
// import 'package:foodrop/core/services/database.dart';
// import 'package:foodrop/core/services/utilities.dart';
// import 'package:foodrop/screens/business/menu/category_selection_screen.dart';
// import 'package:foodrop/screens/common_widgets/camera_image_picker.dart';
// import 'package:provider/provider.dart';
//
// class ItemScreen extends StatefulWidget {
//   ItemScreen({this.businessId, this.db, this.item, this.categories});
//   final String businessId;
//   Item item;
//   final Database db;
//   final List<ItemsCategory> categories;
//
//   @override
//   _ItemScreenState createState() => _ItemScreenState();
// }
//
// class _ItemScreenState extends State<ItemScreen> {
//   Item get _item => widget.item;
//   final _menuItemFormKey = GlobalKey<FormState>();
//
//   TextEditingController _tecName = TextEditingController();
//   TextEditingController _tecPrice = TextEditingController();
//   TextEditingController _tecDescription = TextEditingController();
//   TextEditingController _tecCategory = TextEditingController();
//
//   bool _formSubmittedBefore = false;
//   bool _capturedNewImage = false;
//   File _imageFile;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     if (_item != null) {
//       _tecName.text = _item.name;
//       _tecPrice.text = _item.price.toString();
//       _tecDescription.text = _item.description;
//       setState(() {});
//     } else {
//       widget.item = Item();
//     }
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _tecName.dispose();
//     _tecPrice.dispose();
//     _tecDescription.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     final imageWidget = _item == null || _item.photoUrl == ""
//         ? Container(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height / 5,
//             child: CameraImagePicker(
//               getImage: (imageFile) => setState(
//                 () {
//                   _item.photoUrl = imageFile.path;
//                   _capturedNewImage = true;
//                   _imageFile = imageFile;
//                 },
//               ),
//             ),
//           )
//         : _capturedNewImage
//             ? Image.file(
//                 _imageFile,
//                 fit: BoxFit.cover,
//               )
//             : Image.network(
//                 _item.photoUrl,
//                 fit: BoxFit.cover,
//               );
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(width: double.infinity, child: imageWidget),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: size.height / 15, left: 10, right: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () => Navigator.of(context).pop(),
//                           icon: Icon(
//                             Icons.chevron_left,
//                             size: 48,
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Form(
//               key: _menuItemFormKey,
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       onSaved: (text) => _item.name = text,
//                       controller: _tecName,
//                       decoration: InputDecoration(labelText: "Name"),
//                       validator: (text) => text.isEmpty && _formSubmittedBefore
//                           ? "Cannot be empty"
//                           : null,
//                       // onChanged: (text) => widget.item.name = text,
//                     ),
//                     TextFormField(
//                         onSaved: (text) => _item.price = double.tryParse(text),
//                         controller: _tecPrice,
//                         decoration: InputDecoration(labelText: "Price"),
//                         validator: (price) {
//                           if (double.tryParse(price) != null &&
//                               _formSubmittedBefore) {
//                             return null;
//                           } else {
//                             return "this is an invalid entry";
//                           }
//                         }),
//                     ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 0),
//                       title: _item == null
//                           ? TextFormField(
//                               controller: _tecCategory,
//                               // validator: (text) =>
//                               // _formSubmittedBefore && text.length == 0
//                               //     ? "Please select category"
//                               //     : "null",
//                               style: TextStyle(color: Colors.black26),
//                               // enabled: false,
//                               decoration: InputDecoration(
//                                   disabledBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   border: InputBorder.none,
//                                   labelStyle: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xffdd000000),
//                                   ),
//                                   labelText: "Category: ",
//                                   enabled: false),
//                             )
//                           : TextFormField(
//                               controller: _tecCategory,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black),
//                               decoration: InputDecoration(
//                                   disabledBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   border: InputBorder.none,
//                                   enabled: false,
//                                   labelStyle: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xffdd000000),
//                                   ),
//                                   labelText: "Category: ${_item.categoryName}"),
//                             ),
//                       // subtitle: Text(widget.item.categoryName),
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => Provider<List<ItemsCategory>>(
//                               create: (context) => widget.categories,
//                               child: Consumer<List<ItemsCategory>>(
//                                 builder: (_, categories, __) =>
//                                     CategorySelectionScreen(
//                                         categories: categories,
//                                         defaultCategoryName:
//                                             _item.categoryName == ""
//                                                 ? null
//                                                 : _item.categoryName,
//                                         onSelectedCategory: (selectedCategory) {
//                                           setState(() {
//                                             _item.categoryName =
//                                                 selectedCategory.name;
//                                             _item.categoryId =
//                                                 selectedCategory.docId;
//                                           });
//                                         }),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       trailing: Icon(Icons.chevron_right),
//                     ),
//                     Divider(
//                       thickness: 2,
//                     ),
//                     TextFormField(
//                       // onChanged: (text) => widget.item.description = text,
//                       onSaved: (text) => _item.description = text,
//                       controller: _tecDescription,
//                       maxLines: 10,
//                       decoration: InputDecoration(
//                         labelText: "Description",
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () => _onSaveAndClose(context: context),
//                       child: Text("Save and Close!"),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _onSaveAndClose({@required BuildContext context}) async {
//     _formSubmittedBefore = true;
//     _menuItemFormKey.currentState.validate();
//     _menuItemFormKey.currentState.save();
//
//     try {
//       if (_capturedNewImage) {
//         final urlString = await widget.db.setImage(
//           pickedImage: File(_imageFile.path),
//           docId: Utilities.documentIdFromCurrentDate(),
//           storageCollectionName:
//               APIPath.menuImageStoragePath(businessId: widget.businessId),
//         );
//         _item.photoUrl = urlString;
//         _item.businessId = widget.businessId ?? _item.businessId;
//       }
//
//       await widget.db.setItem(item: _item);
//     } on FirebaseException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(e.message),
//       ));
//     }
//
//     Navigator.of(context).pop();
//   }
// }
>>>>>>> qr_code_feature
