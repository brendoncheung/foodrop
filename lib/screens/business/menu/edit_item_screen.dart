import 'package:flutter/material.dart';

class EditItemScreen extends StatefulWidget {
  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  // TextEditingController _tecName

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {}
}
