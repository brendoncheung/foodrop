import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrop/core/models/QRIntermediate.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/services/factory/QRFactory.dart';
import 'package:foodrop/core/services/repositories/qr_transaction_repository.dart';

import 'package:uuid/uuid.dart';

class QRCodeConfirmationScreen extends StatefulWidget {
  final QRTransaction transaction;
  final Business business;
  final UserProfile user;

  QRCodeConfirmationScreen({
    this.transaction,
    this.business,
    this.user,
  });

  @override
  _QRCodeConfirmationScreenState createState() => _QRCodeConfirmationScreenState();
}

class _QRCodeConfirmationScreenState extends State<QRCodeConfirmationScreen> {
  var repo = QRTransactionRepository(store: FirebaseFirestore.instance);

  var qrFactory = QRCodeWidgetFactory();

  var _isUserConfirmed = false;

  var _uuid = Uuid();

  QRIntermediateTransaction qrIntermediate;
  QRTransaction qrTransaction;

  String qrData;

  void onConfirmTapped() {
    setState(() {
      qrIntermediate = QRIntermediateTransaction(businessId: widget.business.uid, uuid: widget.transaction.uuid);

      qrData = qrIntermediate.toJson();
      repo.addIntermediateTransaction(qrIntermediate);
      repo.addTransaction(widget.transaction);

      _isUserConfirmed = !_isUserConfirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Transfer points"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.user.photoUrl)),
                SizedBox(width: 8),
                Text(widget.user.username),
              ],
            ),
            SizedBox(height: 8),
            Text("Points to be transfered: \$${widget.transaction.dollarAmountTransacted}"),
            SizedBox(height: 16),
            Card(
              elevation: 20,
              child: _isUserConfirmed
                  ? qrFactory.makeQRCodeWidgetWithUuid(qrData)
                  : Container(
                      padding: EdgeInsets.all(8),
                      width: 300,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Only use this to transfer points to your customers",
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: onConfirmTapped,
                            child: Text("Confirm"),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
