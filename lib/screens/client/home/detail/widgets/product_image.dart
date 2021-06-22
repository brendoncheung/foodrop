import 'package:flutter/material.dart';
import 'package:foodrop/core/models/item.dart';

class ProductImage extends StatelessWidget {
  final Item item;

  ProductImage({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child: Stack(children: [
        Image.network(item.photoUrl, fit: BoxFit.cover),
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
