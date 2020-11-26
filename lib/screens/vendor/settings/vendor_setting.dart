import 'package:flutter/material.dart';
import 'package:foodrop/screens/vendor/settings/add_menu_items/vendor_add_edit_menu_items_screen.dart';

class VendorSettingScreen extends StatelessWidget {
  const VendorSettingScreen({Key key}) : super(key: key);

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
        child: Column(children: [
          SwitchListTile(
            onChanged: (value) {
              // TODO make this switch between vendor and user
            },
            value: false,
            title: Text("Switch between vendor and user"),
          ),
          Divider(
            height: 1,
            color: Colors.black45,
          ),
          ListTile(
            title: Text("Add/edit menu items"),
            trailing: IconButton(
              highlightColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(VendorAddEditMenuItemsScreen.ROUTE_NAME);
              },
            ),
          )
        ]),
      ),
    );
  }
}
