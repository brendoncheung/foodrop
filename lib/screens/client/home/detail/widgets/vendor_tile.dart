import 'package:flutter/material.dart';
import 'package:foodrop/core/models/menu.dart';

class VendorTile extends StatelessWidget {
  final Menu homeTile;
  final Function onTap;
  VendorTile({this.homeTile, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundImage: NetworkImage(homeTile.avatar_url)),
        title: Text(
          homeTile.business_name,
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
