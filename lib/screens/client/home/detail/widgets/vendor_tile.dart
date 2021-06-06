import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';

class VendorTile extends StatelessWidget {
  const VendorTile({
    Key key,
    @required HomeTile homeTile,
  })  : _homeTile = homeTile,
        super(key: key);

  final HomeTile _homeTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(_homeTile.avatarurl)),
        title: Text(
          _homeTile.username,
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
