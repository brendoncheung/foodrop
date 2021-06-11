import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

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
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.tradingName),
                ),
                body: _buildChips(context, snapshot.data),
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

  _buildChips(BuildContext context, Business businessData) {
    final _db = Provider.of<Database>(context);
    return StreamBuilder(
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
                return AsyncSnapshotItemBuilder<ItemsCategory>(
                  snapshot: snapshot,
                  itemBuilder: (context, category) => Text(category.name),
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
}
