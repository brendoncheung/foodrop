import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../core/models/UserProfile.dart';
import '../../../core/models/qr_Intermediate.dart';
import '../../../core/models/qr_transaction.dart';

import '../../../core/services/repositories/qr_transaction_repository.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScanScreen extends StatefulWidget {
  @override
  _QRCodeScanScreenState createState() => _QRCodeScanScreenState();
}

class _QRCodeScanScreenState extends State<QRCodeScanScreen> {
  String text = "hello";

  void onTapped(String userId) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode("Green", "Cancel", true, ScanMode.QR);
    QRIntermediateTransaction intermediateTransaction = QRIntermediateTransaction.fromJson(barcode);
    QRTransactionRepository repo = QRTransactionRepository(store: FirebaseFirestore.instance);
    repo.updateTransactionWithRecepientId(intermediateTransaction, userId);

    setState(() {
      text = intermediateTransaction.uuid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProfile>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: user == null
            ? Center(
                child: Text("Please sign in"),
              )
            : Center(
                child: Column(
                  children: [
                    Text(text),
                    ElevatedButton(
                      onPressed: () {
                        onTapped(user.uid);
                      },
                      child: Text("Scan"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
