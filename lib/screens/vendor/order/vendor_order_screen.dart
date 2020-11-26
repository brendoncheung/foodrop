import 'package:flutter/material.dart';

class VendorOrderScreen extends StatelessWidget {
  const VendorOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: Center(
        child: Container(
          child: Text("Vendor order"),
        ),
      ),
    );
  }
}
