import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/qr_Intermediate.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/UserProfile.dart';
import '../../../core/models/business.dart';
import '../../../core/models/qr_transaction.dart';
import '../promo/edit_promo.dart';
import 'qr_code_comfirmation_screen.dart';

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
            child: Text("Confirm"),
            onPressed: () {
              var transaction = QRTransaction(
                businessId: business.uid,
                recipientId: null,
                creatorId: user.uid,
                dollarAmountTransacted: double.parse(contoller.value.text),
                uuid: Uuid().v4(),
              );
              QRIntermediateTransaction intermediateTransaction = QRIntermediateTransaction(uuid: transaction.uuid, businessId: transaction.businessId);

              var repo = QRTransactionRepository(store: FirebaseFirestore.instance);
              var interFuture = repo.addIntermediateTransaction(intermediateTransaction);
              var transactionFuture = repo.addTransaction(transaction);

              Future.wait([interFuture, transactionFuture]).then(
                (value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRCodeConfirmationScreen(
                      transaction: transaction,
                      intermediateTransaction: intermediateTransaction,
                      user: user,
                    ),
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
