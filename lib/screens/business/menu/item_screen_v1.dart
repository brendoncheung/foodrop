import 'package:flutter/material.dart';
import '../../../core/models/item.dart';
import '../../../core/services/custom_colors.dart';

class ItemScreenV1 extends StatefulWidget {
  ItemScreenV1({@required this.item});

  Item item;

  @override
  _ItemScreenV1State createState() => _ItemScreenV1State();
}

class _ItemScreenV1State extends State<ItemScreenV1> {
  Item get _item => widget.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_item.name}"),
        backgroundColor: CustomColors.vendorAppBarColor,
      ),
    );
  }
}
