import 'package:flutter/material.dart';

class VendorPromotionScreen extends StatelessWidget {
  const VendorPromotionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
      ),
      body: Center(
        child: Container(
          child: Text("Vendor promotion"),
        ),
      ),
    );
  }
}
