import 'package:flutter/material.dart';
import 'package:foodrop/core/models/vendor/vendor_menu_item.dart';
import 'package:foodrop/screens/vendor/settings/widgets/vendor_menu_item_list_tile.dart';

class VendorMenuItemListView extends StatelessWidget {
  final List<VendorMenuItem> _menus;
  final void Function(VendorMenuItem) _onTapHandler;

  VendorMenuItemListView({List<VendorMenuItem> list, Function onTapHandler})
      : _menus = list,
        _onTapHandler = onTapHandler;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _menus.length,
      itemBuilder: (context, index) {
        var menu = _menus[index];
        return VendorMenuItemListTile(item: menu);
      },
    );
  }
}
