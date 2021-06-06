import 'package:flutter/material.dart';
import 'package:foodrop/core/models/home_tile.dart';

class ProductImage extends StatelessWidget {
  final HomeTile homeTile;

  ProductImage({this.homeTile});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child: Stack(children: [
        Image.network(homeTile.imageurl, fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
