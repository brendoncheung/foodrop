import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';

class HomeTileDetailScreen extends StatelessWidget {
  static const String ROUTE_NAME = "home/detail";

  HomeTile _homeTile;

  HomeTileDetailScreen({HomeTile homeTile}) {
    this._homeTile = homeTile;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(_homeTile.numSold);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_rounded),
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
              child: Image.network(_homeTile.imageurl, fit: BoxFit.cover),
            ),
            SizedBox(height: 8),
            PriceAndLikeBar(homeTile: _homeTile),
            SizedBox(height: 8),
            Row(
              children: [SizedBox(width: 8), Text("${_homeTile.numSold.toString()} sold", style: TextStyle(color: Colors.white, fontSize: 24))],
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(_homeTile.avatarurl)),
                title: Text(_homeTile.username),
                subtitle: Text("564 fans"),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PriceAndLikeBar extends StatelessWidget {
  const PriceAndLikeBar({
    Key key,
    @required HomeTile homeTile,
  })  : _homeTile = homeTile,
        super(key: key);

  final HomeTile _homeTile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text("\$${_homeTile.price.toString()}", style: TextStyle(color: Colors.red, fontSize: 24)),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(
                  width: 8,
                ),
                Text(_homeTile.numOfFavourites.toString(), style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
