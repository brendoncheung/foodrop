import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/business/item_screen.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

import 'menu/edit_category_modal_form.dart';

class BusinessHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _db = Provider.of<Database>(context);
    final _userProfile = Provider.of<UserProfile>(context);
    print(_userProfile.defaultBusinessId);

    return StreamBuilder<Business>(
        initialData: Business(),
        stream: _db.businessStream(businessUid: _userProfile.defaultBusinessId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Provider<Business>(
                create: (context) => snapshot.data,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(snapshot.data.tradingName),
                  ),
                  body: _buildMenu(context, snapshot.data),
                ),
              );
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Problem loading data"),
            ),
            body: Center(
              child: Text(
                "You have lost access to the business.\nPlease select another store.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        });
  }

  Widget _buildMenu(BuildContext context, Business businessData) {
    final _db = Provider.of<Database>(context);
    return StreamBuilder<List<ItemsCategory>>(
        stream: _db.itemsCategoryStream(businessId: businessData.uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
              break;
            case ConnectionState.active:
              {
                return Column(
                  children: [
                    Wrap(
                      children: [
                        Container(
                          height: 100,
                          // color: Colors.grey,
                          child: AsyncSnapshotItemBuilder<ItemsCategory>(
                              businessId: businessData.uid,
                              snapshot: snapshot,
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
                                      key: Key(category.hashCode.toString()),
                                      shadowColor: Colors.black,
                                      label: Text(category.name),
                                      avatar: Text(
                                        category.index.toString(),
                                      ),
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
                    Expanded(
                        child: _buildBodyToShowItems(_db, businessData.uid))
                  ],
                );
              }
              break;
            default:
              return Center(child: CircularProgressIndicator());
          }
        });
    // return Chip(
    //   labelPadding: EdgeInsets.all(4),
    //   avatar: CircleAvatar(
    //     child: Text("AZ"),
    //     backgroundColor: Colors.white.withOpacity(0.8),
    //   ),
    //   label: Text('Chip'),
    //   backgroundColor: Colors.red,
    // );
  }

  Container _buildBodyToShowItems(Database _db, String businessId) {
    return Container(
      // color: Colors.deepOrange,
      child: StreamBuilder<List<Item>>(
        stream: _db.itemsStream(businessId: businessId),
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
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        // tileColor: Colors.green,
                        title: Text(item.name),
                        subtitle: Text("${item.categoryName}"),
                        selectedTileColor: Colors.black26,
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemScreen(db: _db, item: item))),
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
