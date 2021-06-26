import 'package:flutter/material.dart';

class ClientGiftScreen extends StatelessWidget {
  const ClientGiftScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gift")),
      body: Container(
        child: Center(
          child: Text("gift"),
        ),
      ),
    );
  }
}
