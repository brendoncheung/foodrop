import 'package:flutter/material.dart';
import 'package:foodrop/core/models/vendor/vendor_menu_item.dart';

class VendorMenuItemListTile extends StatelessWidget {
  final VendorMenuItem _item;

  VendorMenuItemListTile({VendorMenuItem item}) : _item = item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _item.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        _item.description,
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Text(
        "\$${_item.price}",
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
