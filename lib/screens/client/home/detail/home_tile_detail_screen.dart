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
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
              child: Image.network(_homeTile.imageurl, fit: BoxFit.cover),
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("\$${_homeTile.price.toString()}", style: TextStyle(color: Colors.red, fontSize: 18)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
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
            )
          ],
        ),
      ),
    );
  }
}
