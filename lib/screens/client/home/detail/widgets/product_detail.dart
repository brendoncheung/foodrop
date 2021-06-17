import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product Details", style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 8),
            Image.asset('./assets/images/food_detail/1.jpg'),
            SizedBox(height: 8),
            Image.asset('./assets/images/food_detail/2.jpg'),
          ],
        ),
      ),
    );
  }
}
