import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/settings/vendor_add_menu_items_screen.dart';
import 'package:foodrop/screens/vendor/settings/vendor_edit_menu_items_screen.dart';
import 'package:foodrop/screens/vendor/settings/widgets/vendor_setting_screen_list_tile.dart';

class VendorSettingScreen extends StatelessWidget {
  void onTapHandler() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        actions: [IconButton(icon: Icon(Icons.switch_account), onPressed: () {})],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SwitchListTile(
              onChanged: (value) {
                // TODO make this switch between vendor and user
              },
              value: false,
              title: Text("Client mode"),
              subtitle: Text(
                "This will switch to client mode",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black45,
            ),
            Expanded(
              child: ListView(
                children: [
                  VendorSettingScreenListTile(
                      title: "Menu item",
                      subtitle: "Add something!",
                      onTapHandler: () {
                        Navigator.of(context).pushNamed(VendorAddMenuItemsScreen.ROUTE_NAME);
                      }),
                  VendorSettingScreenListTile(
                      title: "Restaurant details",
                      subtitle: "Configure your business!",
                      onTapHandler: () {
                        Navigator.of(context).pushNamed(VendorAddMenuItemsScreen.ROUTE_NAME);
                      }),
                  VendorSettingScreenListTile(
                      title: "Profile",
                      subtitle: "View your stuff",
                      onTapHandler: () {
                        Navigator.of(context).pushNamed(VendorAddMenuItemsScreen.ROUTE_NAME);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
