import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/screens/client/home/detail/widgets/price_and_like_bar.dart';
import 'package:foodrop/screens/client/home/detail/widgets/product_detail.dart';
import 'package:foodrop/screens/client/home/detail/widgets/product_image.dart';
import 'package:foodrop/screens/client/home/detail/widgets/product_review.dart';
import 'package:foodrop/screens/client/home/detail/widgets/product_suggestion.dart';
import 'package:foodrop/screens/client/home/detail/widgets/vendor_tile_widget.dart';

class HomeTileDetailScreen extends StatelessWidget {
  static const String ROUTE_NAME = "home/detail";

  Item item;

  HomeTileDetailScreen({this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(item.numOfFavs);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(item.name),
        actions: [
          IconButton(
              icon: Icon(
            Icons.share_rounded,
            color: Colors.white,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductImage(item: item),
              SizedBox(height: 8),
              PriceAndLikeBar(item: item),
              Row(
                children: [SizedBox(width: 8), Text("${item.numSold.toString()} sold", style: TextStyle(color: Colors.white, fontSize: 16))],
              ),
              SizedBox(height: 8),
              VendorTileWidget(
                item: item,
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("vendor tile selected")));
                },
              ),
              SizedBox(height: 8),
              ProductReview(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("product review tile selected")));
                },
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.grey[800],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Product Suggestion (5)",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              ProductDetail(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
