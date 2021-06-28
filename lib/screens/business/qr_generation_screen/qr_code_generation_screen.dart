import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';
import 'package:foodrop/screens/business/qr_generation_screen/qr_code_comfirmation_screen.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../promo/edit_promo.dart';

class QRCodeGenerationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var business = Provider.of<Business>(context);
    var user = Provider.of<UserProfile>(context);

    var factory = QRCodeWidgetFactory();
    var contoller = TextEditingController();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Align(child: Text("Promotion")),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditPromo.show(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (size.width * 0.2)),
            child: TextField(
              controller: contoller,
            ),
          ),
          TextButton(
            child: Text("Generate"),
            onPressed: () {
              var transaction = QRTransaction(
                businessId: business.uid,
                creatorId: user.uid,
                dollarAmountTransacted: double.parse(contoller.text),
                recipientId: null,
              );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contexxt) => QRCodeConfirmationScreen(transaction: transaction),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
