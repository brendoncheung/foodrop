import 'package:flutter/material.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/item.dart';
import 'package:foodrop/core/models/items_category.dart';
import 'package:foodrop/core/services/custom_colors.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/business/item_screen.dart';
import 'package:foodrop/screens/business/menu/edit_category_modal_form.dart';
import 'package:foodrop/screens/business/menu/item_screen_v1.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:provider/provider.dart';

class BusinessHomeScreenV1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _business = Provider.of<Business>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.vendorAppBarColor,
        title: Text(
          _business.tradingName,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Text(
        "Under Development",
        style: TextStyle(fontSize: 28),
      )),
    );
  }
}
