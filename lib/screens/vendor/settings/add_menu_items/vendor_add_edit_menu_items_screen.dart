import 'package:flutter/material.dart';
import 'package:foodrop/core/repositories/vendor/vendor_menu_item_repository.dart';
import 'package:provider/provider.dart';

class VendorAddEditMenuItemsScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/vendor_setting_add_edit_menu_item_screen";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add items"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Consumer<VendorMenuItemRepository>(
        builder: (ctx, repo, child) {
          return repo.itemCount == 0
              ? Center(
                  child: Text("ADD MORE ITEMS"),
                )
              : Center(
                  child: Text("add or edit menu items"),
                );
        },
      ),
      floatingActionButton: Consumer<VendorMenuItemRepository>(
        builder: (ctx, repo, child) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              print("repo hash: ${repo.hashCode}");
              repo.addMenuItem(null);
            },
          );
        },
      ),
    );
  }
}
