import 'package:flutter/material.dart';

class BusinessGlanceTile extends StatelessWidget {
  final String title;
  final int number;

  BusinessGlanceTile({this.title, this.number});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text("$number"),
    );
  }
}
