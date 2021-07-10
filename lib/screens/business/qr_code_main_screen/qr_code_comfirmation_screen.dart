import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/models/UserProfile.dart';
import '../../../core/models/business.dart';
import '../../../core/models/qr_Intermediate.dart';
import '../../../core/models/qr_transaction.dart';
import '../../../core/services/factory/QRFactory.dart';
import '../../../core/services/repositories/qr_transaction_repository.dart';

class QRCodeConfirmationScreen extends StatefulWidget {
  final UserProfile user;
  final QRTransaction transaction;
  final QRIntermediateTransaction intermediateTransaction;

  QRCodeConfirmationScreen({
    this.user,
    this.transaction,
    this.intermediateTransaction,
  });

  @override
  _QRCodeConfirmationScreenState createState() => _QRCodeConfirmationScreenState();
}

class _QRCodeConfirmationScreenState extends State<QRCodeConfirmationScreen> {
  var repo = QRTransactionRepository(store: FirebaseFirestore.instance);

  var qrFactory = QRCodeWidgetFactory();

  var _isUserConfirmed = false;
  var _text = "waiting for user to scan";

  QRIntermediateTransaction qrIntermediate;
  QRTransaction qrTransaction;

  String qrData;

  void onConfirmTapped() {
    setState(() {
      _isUserConfirmed = !_isUserConfirmed;
      qrData = widget.intermediateTransaction.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Transfer points"),
      ),
      body: StreamBuilder<QRTransaction>(
          stream: repo.fetchQRTransactionByUuidStream(businessId: widget.transaction.businessId, uuid: widget.transaction.uuid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.recipientId != null) {
                _text = "${snapshot.data.recipientId}: received points successfully";
              }
            }

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AvatarWithName(widget: widget),
                  SizedBox(height: 8),
                  PointsToBeTransferedIndicator(widget: widget),
                  SizedBox(height: 16),
                  QRCodeWithConfirmation(
                    isUserConfirmed: _isUserConfirmed,
                    qrData: qrData,
                    onConfirmTapped: onConfirmTapped,
                  ),
                  SizedBox(height: 16),
                  Text(_text),
                  SizedBox(height: 16),
                  Text(widget.transaction.uuid),
                ],
              ),
            );
          }),
    );
  }
}

class PointsToBeTransferedIndicator extends StatelessWidget {
  const PointsToBeTransferedIndicator({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final QRCodeConfirmationScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text("Points to be transfered: \$${widget.transaction.dollarAmountTransacted}");
  }
}

class AvatarWithName extends StatelessWidget {
  const AvatarWithName({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final QRCodeConfirmationScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundImage: NetworkImage(widget.user.photoUrl)),
        SizedBox(width: 8),
        Text(widget.user.username),
      ],
    );
  }
}

class QRCodeWithConfirmation extends StatelessWidget {
  QRCodeWithConfirmation({
    this.isUserConfirmed,
    this.qrData,
    this.onConfirmTapped,
  });

  final bool isUserConfirmed;
  final String qrData;
  final Function onConfirmTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: !isUserConfirmed
            ? Container(
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
              )
            : QRCodeWidgetFactory().makeQRCodeWidgetWithUuid(qrData));
  }
}
