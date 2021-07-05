import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';
import 'package:foodrop/screens/business/qr_code_main_screen/qr_code_comfirmation_screen.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'dart:math';

import '../promo/edit_promo.dart';

class QRCodeGenerationScreen extends StatelessWidget {
  final Business business;
  final UserProfile user;

  QRCodeGenerationScreen({
    @required this.business,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var contoller = TextEditingController();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Align(child: Text("Transfer points")),
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
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.attach_money),
                fillColor: Colors.white,
                focusColor: Colors.white,
              ),
              controller: contoller,
            ),
          ),
          ElevatedButton(
            child: Text("Generate"),
            onPressed: () {
              var transaction = QRTransaction(
                businessId: business.uid,
                recipientId: null,
                creatorId: user.uid,
                dollarAmountTransacted: double.parse(contoller.value.text),
                uuid: Uuid().v1(),
              );

              print("pressed");

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contexxt) => QRCodeConfirmationScreen(
                    transaction: transaction,
                    business: business,
                    user: user,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
