import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';

class VendorTile extends StatelessWidget {
  final HomeTile homeTile;
  final Function onTap;
  VendorTile({this.homeTile, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundImage: NetworkImage(homeTile.avatarurl)),
        title: Text(
          homeTile.username,
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
