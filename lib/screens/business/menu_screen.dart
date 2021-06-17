import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: _buildChips(),
    );
  }

  _buildChips() {
    return Chip(
      labelPadding: EdgeInsets.all(4),
      avatar: CircleAvatar(
        child: Text("AZ"),
        backgroundColor: Colors.white.withOpacity(0.8),
      ),
      label: Text('Chip'),
      backgroundColor: Colors.red,
    );
  }
}
