import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/custom_colors.dart';
// import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/business/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:foodrop/screens/business/menu/edit_category_modal_form.dart';
import 'package:foodrop/screens/business/menu/item_screen_v1.dart';
// import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _business = Provider.of<Business>(context, listen: false);
    final _db = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<ItemsCategory>>(
      stream: _db.itemsCategoryStream(businessId: _business.uid),
      builder: (context, categoryListSnapshot) {
        switch (categoryListSnapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return CircularProgressIndicator();
            }
            break;
          case ConnectionState.active:
            {
              if (categoryListSnapshot.hasData) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: CustomColors.vendorAppBarColor,
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItemScreenV1(
                          db: _db,
                          businessId: _business.uid,
                          categories: categoryListSnapshot.data,
                        ),
                      ),
                    ),
                  ),
                  appBar: AppBar(
                    backgroundColor: CustomColors.vendorAppBarColor,
                    title: Text(
                      _business.tradingName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: _buildBody(context, _business, categoryListSnapshot),
                );
              }
              return CircularProgressIndicator();
            }
            break;
          default:
            {
              return CircularProgressIndicator();
            }
        }
      },
    );
  }

  // _buildBody(BuildContext context, Database _db) {
  //   final _business = Provider.of<Business>(context, listen: false);
  //   // final _db = Provider.of<Database>(context, listen: false);
  //
  //   return StreamBuilder<List<ItemsCategory>>(
  //     stream: _db.itemsCategoryStream(businessId: _business.uid),
  //     builder: (context, categoryListSnapshot) {
  //       switch (categoryListSnapshot.connectionState) {
  //         case ConnectionState.waiting:
  //           {
  //             return CircularProgressIndicator();
  //           }
  //           break;
  //         case ConnectionState.active:
  //           {
  //             if (categoryListSnapshot.hasData) {
  //               return Scaffold(
  //                 floatingActionButton: FloatingActionButton(
  //                   child: Icon(Icons.add),
  //                   backgroundColor: CustomColors.vendorAppBarColor,
  //                   onPressed: () {},
  //                 ),
  //                 body: _buildMenu(context, _business, categoryListSnapshot),
  //               );
  //             }
  //             return CircularProgressIndicator();
  //           }
  //           break;
  //         default:
  //           {
  //             return CircularProgressIndicator();
  //           }
  //       }
  //     },
  //   );
  // }

  Widget _buildBody(BuildContext context, Business businessData,
      AsyncSnapshot<List<ItemsCategory>> _categorySnapshot) {
    final _db = Provider.of<Database>(context, listen: false);
    return Column(
      children: [
        Wrap(
          children: [
            Container(
              height: 50,
              // color: Colors.grey,
              child: AsyncSnapshotItemBuilder<ItemsCategory>(
                  businessId: businessData.uid,
                  snapshot: _categorySnapshot,
                  withDivider: false,
                  db: _db,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, category) {
                    return InkWell(
                      onDoubleTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            category.businessId = businessData.uid;
                            return EditCategoryModalForm(
                              item: category,
                              db: _db,
                              // businessId: businessData.uid,
                            );
                          }),
                      child: Padding(
                        key: Key(category.hashCode.toString()),
                        padding: EdgeInsets.all(10),
                        child: ActionChip(
                          backgroundColor: category.isActive
                              ? CustomColors.vendorActionChipColor
                              : null,
                          key: Key(category.hashCode.toString()),
                          shadowColor: Colors.black,
                          label: Text(
                              "${category.index.toString()} ${(category.name)}"),
                          onPressed: () {
                            //TODO: animated listcontroller
                            print("scrolled to the right position");
                          },
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
        Divider(
          thickness: 2,
        ),
        Expanded(
            child: _buildBodyToShowItems(
                db: _db,
                businessId: businessData.uid,
                categoriesList: _categorySnapshot.data))
      ],
    );
  }

  Container _buildBodyToShowItems(
      {Database db, String businessId, List<ItemsCategory> categoriesList}) {
    return Container(
      // color: Colors.deepOrange,
      child: StreamBuilder<List<Item>>(
        stream: db.businessItemsStreamByBusinessId(businessId: businessId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
              break;
            case ConnectionState.active:
              {
                return AsyncSnapshotItemBuilder<Item>(
                  snapshot: snapshot,
                  itemBuilder: (context, item) {
                    final mainPhotoUrl = item.photoUrlList[0];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemScreenV1(
                              item: item,
                              db: db,
                              businessId: businessId,
                              categories: categoriesList),
                        ),
                      ),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(mainPhotoUrl))),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          isThreeLine: true,
                                          dense: true,
                                          title: Text(item.name),
                                          subtitle: Text(item.description),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text("\$${double.tryParse(
                                                item.price.toString(),
                                              )}")),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // child: ListTile(
                        //   // tileColor: Colors.green,
                        //   title: Text(item.name),
                        //   subtitle: Text("${item.categoryName}"),
                        //   selectedTileColor: Colors.black26,
                        //   onTap: () => Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => ItemScreenV1(
                        //         item: item,
                        //         db: db,
                        //         businessId: businessId,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    );
                  },
                );
              }
              break;
            default:
              {
                return CircularProgressIndicator();
              }
          }
        },
      ),
    );
  }
}
