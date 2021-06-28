import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';

class QRCodeConfirmationScreen extends StatelessWidget {
  final QRTransaction transaction;
  QRCodeConfirmationScreen({@required this.transaction});

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
            factory.makeQRCodeWidget(transaction),
            Text(transaction.toMap().toString()),
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
