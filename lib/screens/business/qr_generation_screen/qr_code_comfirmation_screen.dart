import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';

class QRCodeConfirmationScreen extends StatelessWidget {
  final QRTransaction transaction;
  final UserProfile user;

  QRCodeConfirmationScreen({@required this.transaction, @required this.user});

  @override
  Widget build(BuildContext context) {
    var repo = QRTransactionRepository(store: FirebaseFirestore.instance);
    var factory = QRCodeWidgetFactory();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                SizedBox(width: 8),
                Text(user.username),
              ],
            ),
            SizedBox(height: 8),
            Text("Points to be transfered: \$${transaction.dollarAmountTransacted}"),
            SizedBox(height: 16),
            Card(
              elevation: 12,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: factory.makeQRCodeWidget(transaction),
              ),
            ),
            SizedBox(height: 16),
            Text(transaction.toMap().toString(), textAlign: TextAlign.center),
            Text(transaction.creationTime.toString()),
            Text(transaction.businessId),
            Text(transaction.creatorId),
            Text(transaction.dollarAmountTransacted.toString()),
            ElevatedButton(
                onPressed: () {
                  repo.addTransaction(transaction);
                },
                child: Text("Confirm"))
          ],
        ),
      ),
    );
  }
}
