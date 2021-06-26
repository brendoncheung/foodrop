// <<<<<<< HEAD
// // import 'package:flutter/material.dart';
// // import 'package:foodrop/core/models/UserProfile.dart';
// // import 'package:foodrop/core/models/business.dart';
// // import 'package:foodrop/core/models/item.dart';
// // import 'package:foodrop/core/models/items_category.dart';
// // import 'package:foodrop/core/services/database.dart';
// // import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
// // import 'package:foodrop/screens/common_widgets/empty_content.dart';
// // import 'package:provider/provider.dart';
// //
// // import 'menu/edit_category_modal_form.dart';
// // import 'menu/edit_item_screen.dart';
// // import 'menu/item_screen.dart';
// //
// // class BusinessHomeScreen extends StatefulWidget {
// //   @override
// //   _BusinessHomeScreenState createState() => _BusinessHomeScreenState();
// // }
// //
// // class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final _db = Provider.of<Database>(context);
// //     final _userProfile = Provider.of<UserProfile>(context);
// //
// //     List<ItemsCategory> categories;
// //
// //     if (_userProfile != null) {
// //       if (_userProfile.defaultBusinessId != null &&
// //           _userProfile.defaultBusinessId == "") {
// //         return Scaffold(
// //           appBar: AppBar(
// //             title: Text("You are not linked to business"),
// //           ),
// //           body: EmptyContent(),
// //         );
// //       }
// //     }
// //
// //     return StreamBuilder<Business>(
// //         initialData: Business(),
// //         stream: _db.businessStream(businessUid: _userProfile.defaultBusinessId),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.active) {
// //             if (snapshot.hasData) {
// //               return Provider<Business>(
// //                 create: (context) => snapshot.data,
// //                 child: StreamBuilder<List<ItemsCategory>>(
// //                   stream:
// //                       _db.itemsCategoryStream(businessId: snapshot.data.uid),
// //                   builder: (context, categoryListSnapshot) {
// //                     switch (categoryListSnapshot.connectionState) {
// //                       case ConnectionState.waiting:
// //                         {
// //                           return CircularProgressIndicator();
// //                         }
// //                         break;
// //                       case ConnectionState.active:
// //                         {
// //                           if (categoryListSnapshot.hasData) {
// //                             return Scaffold(
// //                               floatingActionButton: FloatingActionButton(
// //                                 child: Icon(Icons.add),
// //                                 onPressed: () => Navigator.of(context).push(
// //                                   MaterialPageRoute(
// //                                       builder: (context) => ItemScreen(
// //                                             businessId: snapshot.data.uid,
// //                                             db: _db,
// //                                             categories:
// //                                                 categoryListSnapshot.data,
// //                                           ),
// //                                       fullscreenDialog: true),
// //                                 ),
// //                               ),
// //                               appBar: AppBar(
// //                                 title: Text(snapshot.data.tradingName),
// //                               ),
// //                               body: _buildMenu(
// //                                   context, snapshot.data, categoryListSnapshot),
// //                             );
// //                           }
// //                           return CircularProgressIndicator();
// //                         }
// //                         break;
// //                       default:
// //                         {
// //                           return CircularProgressIndicator();
// //                         }
// //                     }
// //                   },
// //                 ),
// //               );
// //             }
// //           }
// //           return Scaffold(
// //             appBar: AppBar(
// //               title: Text("Problem loading data"),
// //             ),
// //             body: Center(
// //               child: Text(
// //                 "You have lost access to the business.\nPlease select another store.",
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           );
// //         });
// //   }
// //
// //   Widget _buildMenu(BuildContext context, Business businessData,
// //       AsyncSnapshot<List<ItemsCategory>> _categorySnapshot) {
// //     final _db = Provider.of<Database>(context);
// //     return Column(
// //       children: [
// //         Wrap(
// //           children: [
// //             Container(
// //               height: 50,
// //               // color: Colors.grey,
// //               child: AsyncSnapshotItemBuilder<ItemsCategory>(
// //                   businessId: businessData.uid,
// //                   snapshot: _categorySnapshot,
// //                   withDivider: false,
// //                   db: _db,
// //                   scrollDirection: Axis.horizontal,
// //                   itemBuilder: (context, category) {
// //                     return InkWell(
// //                       onDoubleTap: () => showModalBottomSheet(
// //                           isScrollControlled: true,
// //                           context: context,
// //                           builder: (context) {
// //                             category.businessId = businessData.uid;
// //                             return EditCategoryModalForm(
// //                               item: category,
// //                               db: _db,
// //                               // businessId: businessData.uid,
// //                             );
// //                           }),
// //                       child: Padding(
// //                         key: Key(category.hashCode.toString()),
// //                         padding: EdgeInsets.all(10),
// //                         child: ActionChip(
// //                           backgroundColor:
// //                               category.isActive ? Colors.amber : null,
// //                           key: Key(category.hashCode.toString()),
// //                           shadowColor: Colors.black,
// //                           label: Text(
// //                               "${category.index.toString()} ${(category.name)}"),
// //                           onPressed: () {
// //                             //TODO: animated listcontroller
// //                             print("scrolled to the right position");
// //                           },
// //                         ),
// //                       ),
// //                     );
// //                   }),
// //             )
// //           ],
// //         ),
// //         Divider(
// //           thickness: 2,
// //         ),
// //         Expanded(
// //             child: _buildBodyToShowItems(
// //                 db: _db,
// //                 businessId: businessData.uid,
// //                 categoriesList: _categorySnapshot.data))
// //       ],
// //     );
// //   }
// //
// //   Container _buildBodyToShowItems(
// //       {Database db, String businessId, List<ItemsCategory> categoriesList}) {
// //     return Container(
// //       // color: Colors.deepOrange,
// //       child: StreamBuilder<List<Item>>(
// //         stream: db.businessItemsStreambyBusinessId(businessId: businessId),
// //         builder: (context, snapshot) {
// //           switch (snapshot.connectionState) {
// //             case ConnectionState.waiting:
// //               {
// //                 return Center(child: CircularProgressIndicator());
// //               }
// //               break;
// //             case ConnectionState.active:
// //               {
// //                 return AsyncSnapshotItemBuilder<Item>(
// //                   snapshot: snapshot,
// //                   itemBuilder: (context, item) {
// //                     return Card(
// //                       elevation: 2,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(16)),
// //                       child: ListTile(
// //                         // tileColor: Colors.green,
// //                         title: Text(item.name),
// //                         subtitle: Text("${item.categoryName}"),
// //                         selectedTileColor: Colors.black26,
// //                         onTap: () => Navigator.of(context).push(
// //                             MaterialPageRoute(
// //                                 builder: (context) => ItemScreen(
// //                                     db: db,
// //                                     item: item,
// //                                     categories: categoriesList))),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               }
// //               break;
// //             default:
// //               {
// //                 return CircularProgressIndicator();
// //               }
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// =======
// import 'package:flutter/material.dart';
// import 'package:foodrop/core/models/UserProfile.dart';
// import 'package:foodrop/core/models/business.dart';
// import 'package:foodrop/core/models/item.dart';
// import 'package:foodrop/core/models/items_category.dart';
// import 'package:foodrop/core/services/database/database.dart';
// import 'package:foodrop/screens/business/common_widgets/asyncSnapshot_Item_Builder.dart';
// import 'package:foodrop/screens/business/common_widgets/empty_content.dart';
// import 'package:provider/provider.dart';
//
// import 'menu/edit_category_modal_form.dart';
// import 'menu/edit_item_screen.dart';
//
// class BusinessHomeScreen extends StatefulWidget {
//   @override
//   _BusinessHomeScreenState createState() => _BusinessHomeScreenState();
// }
//
// class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final _db = Provider.of<Database>(context);
//     final _userProfile = Provider.of<UserProfile>(context);
//
//     List<ItemsCategory> categories;
//
//     if (_userProfile != null) {
//       if (_userProfile.defaultBusinessId != null && _userProfile.defaultBusinessId == "") {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("You are not linked to business"),
//           ),
//           body: EmptyContent(),
//         );
//       }
//     }
//
//     return StreamBuilder<Business>(
//         initialData: Business(),
//         stream: _db.businessStream(businessUid: _userProfile.defaultBusinessId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               return Provider<Business>(
//                 create: (context) => snapshot.data,
//                 child: StreamBuilder<List<ItemsCategory>>(
//                   stream: _db.itemsCategoryStream(businessId: snapshot.data.uid),
//                   builder: (context, categoryListSnapshot) {
//                     switch (categoryListSnapshot.connectionState) {
//                       case ConnectionState.waiting:
//                         {
//                           return CircularProgressIndicator();
//                         }
//                         break;
//                       case ConnectionState.active:
//                         {
//                           if (categoryListSnapshot.hasData) {
//                             return Scaffold(
//                               floatingActionButton: FloatingActionButton(
//                                 child: Icon(Icons.add),
//                                 // onPressed: () => Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => ItemScreen(
//                                 //             businessId: snapshot.data.uid,
//                                 //             db: _db,
//                                 //             categories:
//                                 //                 categoryListSnapshot.data,
//                                 //           ),
//                                 //       fullscreenDialog: true),
//                                 // ),
//                               ),
//                               appBar: AppBar(
//                                 title: Text(snapshot.data.tradingName),
//                               ),
//                               body: _buildMenu(context, snapshot.data, categoryListSnapshot),
//                             );
//                           }
//                           return CircularProgressIndicator();
//                         }
//                         break;
//                       default:
//                         {
//                           return CircularProgressIndicator();
//                         }
//                     }
//                   },
//                 ),
//               );
//             }
//           }
//           return Scaffold(
//             appBar: AppBar(
//               title: Text("Problem loading data"),
//             ),
//             body: Center(
//               child: Text(
//                 "You have lost access to the business.\nPlease select another store.",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget _buildMenu(BuildContext context, Business businessData, AsyncSnapshot<List<ItemsCategory>> _categorySnapshot) {
//     final _db = Provider.of<Database>(context);
//     return Column(
//       children: [
//         Wrap(
//           children: [
//             Container(
//               height: 50,
//               // color: Colors.grey,
//               child: AsyncSnapshotItemBuilder<ItemsCategory>(
//                   businessId: businessData.uid,
//                   snapshot: _categorySnapshot,
//                   withDivider: false,
//                   db: _db,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, category) {
//                     return InkWell(
//                       onDoubleTap: () => showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (context) {
//                             category.businessId = businessData.uid;
//                             return EditCategoryModalForm(
//                               item: category,
//                               db: _db,
//                               // businessId: businessData.uid,
//                             );
//                           }),
//                       child: Padding(
//                         key: Key(category.hashCode.toString()),
//                         padding: EdgeInsets.all(10),
//                         child: ActionChip(
//                           backgroundColor: category.isActive ? Colors.amber : null,
//                           key: Key(category.hashCode.toString()),
//                           shadowColor: Colors.black,
//                           label: Text("${category.index.toString()} ${(category.name)}"),
//                           onPressed: () {
//                             //TODO: animated listcontroller
//                             print("scrolled to the right position");
//                           },
//                         ),
//                       ),
//                     );
//                   }),
//             )
//           ],
//         ),
//         Divider(
//           thickness: 2,
//         ),
//         Expanded(child: _buildBodyToShowItems(db: _db, businessId: businessData.uid, categoriesList: _categorySnapshot.data))
//       ],
//     );
//   }
//
//   Container _buildBodyToShowItems({Database db, String businessId, List<ItemsCategory> categoriesList}) {
//     return Container(
//       // color: Colors.deepOrange,
//       child: StreamBuilder<List<Item>>(
//         stream: db.businessItemsStreambyBusinessId(businessId: businessId),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               {
//                 return Center(child: CircularProgressIndicator());
//               }
//               break;
//             case ConnectionState.active:
//               {
//                 return AsyncSnapshotItemBuilder<Item>(
//                   snapshot: snapshot,
//                   itemBuilder: (context, item) {
//                     return Card(
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                       child: ListTile(
//                         // tileColor: Colors.green,
//                         title: Text(item.name),
//                         subtitle: Text("${item.categoryName}"),
//                         selectedTileColor: Colors.black26,
//                         // onTap: () => Navigator.of(context).push(
//                         //     MaterialPageRoute(
//                         //         builder: (context) => ItemScreen(
//                         //             db: db,
//                         //             item: item,
//                         //             categories: categoriesList))),
//                       ),
//                     );
//                   },
//                 );
//               }
//               break;
//             default:
//               {
//                 return CircularProgressIndicator();
//               }
//           }
//         },
//       ),
//     );
//   }
// }
// >>>>>>> brendon
