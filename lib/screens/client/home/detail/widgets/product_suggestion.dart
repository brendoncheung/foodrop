import 'package:flutter/material.dart';

class ProductSuggestion extends StatelessWidget {
  const ProductSuggestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Text("Products you might like"),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          itemBuilder: (context, index) {
            return Text(
              "Text ${index}",
              style: TextStyle(fontSize: 90, color: Colors.black),
            );
          },
        ),
      ]),
    );
  }
}
