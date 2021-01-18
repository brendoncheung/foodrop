import 'package:flutter/material.dart';
import 'package:foodrop/core/repositories/vendor/vendor_menu_item_repository.dart';
import 'package:foodrop/screens/vendor/settings/widgets/vendor_menu_item_grid_view.dart';
import 'package:provider/provider.dart';

class VendorEditMenuItemsScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/vendor_setting_edit_menu_item_screen";

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
              : VendorMenuItemListView(list: repo.allItems);
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