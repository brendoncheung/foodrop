import 'package:flutter/material.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:provider/provider.dart';

import 'edit_promo.dart';

class PromotionScreen extends StatelessWidget {
  var factory = QRFactory();

  @override
  Widget build(BuildContext context) {
    var business = Provider.of<Business>(context);
    print(business.toMap().toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Promotion"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditPromo.show(context),
          )
        ],
      ),
      body: Center(
        child: Text(business.chineseName),
      ),
    );
  }
}
