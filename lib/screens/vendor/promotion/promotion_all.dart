import 'package:flutter/material.dart';

class PromotionAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // needs one with slivers property
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10),
              color: Colors.red,
              height: 100,
            );
          }, childCount: 10))
        ],
      ),
    );
  }
}
