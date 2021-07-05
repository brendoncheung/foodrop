import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/custom_colors.dart';
// import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/business/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:foodrop/screens/business/common_widgets/show_alert_dialog.dart';
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
                          businessAvatarUrl: _business.businessAvatarUrl,
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

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 50,
        ),
      );

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
            child: _buildBodyToShowItems(context,
                business: businessData,
                db: _db,
                categoriesList: _categorySnapshot.data))
      ],
    );
  }

  Container _buildBodyToShowItems(BuildContext context,
      {Database db, List<ItemsCategory> categoriesList, Business business}) {
    final _user = Provider.of<UserProfile>(context, listen: false);
    return Container(
      // color: Colors.deepOrange,
      child: StreamBuilder<List<Item>>(
        stream: db.businessItemsStreamByBusinessId(businessId: business.uid),
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
                    return Dismissible(
                      onDismissed: (direction) => _dismissAction(
                        context: context,
                        db: db,
                        businessId: business.uid,
                        itemDocId: item.docId,
                      ),
                      direction: DismissDirection.endToStart,
                      key: ObjectKey(item),
                      background: buildSwipeActionLeft(),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ItemScreenV1(
                                userId: _user.uid,
                                item: item,
                                db: db,
                                businessId: business.uid,
                                businessAvatarUrl: business.businessAvatarUrl,
                                categories: categoriesList),
                          ),
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: EdgeInsets.all(0),
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
                                          child: Image.network(
                                            mainPhotoUrl,
                                            width: 200,
                                            // height: 250,
                                          ))),
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
                                                alignment:
                                                    Alignment.bottomRight,
                                                child:
                                                    Text("\$${double.tryParse(
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
                        ),
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

  _dismissAction(
      {BuildContext context,
      Database db,
      String businessId,
      String itemDocId}) async {
    final confirmDeleteItem = await showAlertDialog(
      context,
      title: "Deleting menu item",
      content: "Press delete to remove item permanently.",
      defaultActionText: "Delete",
      cancelActionText: "Cancel",
    );

    if (confirmDeleteItem) {
      db.deleteItem(businessId, itemDocId);
      return print("dismissed!!!!!!");
    }
  }
}
