import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';
import 'package:foodrop/screens/client/home/detail/widgets/price_and_like_bar.dart';
import 'package:foodrop/screens/client/home/detail/widgets/product_review.dart';
import 'package:foodrop/screens/client/home/detail/widgets/vendor_tile.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
                child: Image.network(_homeTile.imageurl, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              PriceAndLikeBar(homeTile: _homeTile),
              Row(
                children: [SizedBox(width: 8), Text("${_homeTile.numSold.toString()} sold", style: TextStyle(color: Colors.white, fontSize: 16))],
              ),
              SizedBox(height: 8),
              VendorTile(homeTile: _homeTile),
              SizedBox(height: 8),
              ProductReview()
            ],
          ),
        ),
      ),
    );
  }
}
