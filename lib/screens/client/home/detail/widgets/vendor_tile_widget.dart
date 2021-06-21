import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class VendorTileWidget extends StatelessWidget {
  final Item item;
  final Function onTap;
  VendorTileWidget({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundImage: NetworkImage(item.businessAvatarUrl)),
        title: Text(
          item.businessId,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "564 fans",
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
