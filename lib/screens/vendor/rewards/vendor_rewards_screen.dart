import "package:flutter/material.dart";

class VendorRewardScreen extends StatelessWidget {
  const VendorRewardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rewards")),
      body: Center(
        child: Container(
          child: Text("Vendor rewards"),
        ),
      ),
    );
  }
}
