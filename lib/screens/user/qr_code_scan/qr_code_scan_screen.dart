import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScanScreen extends StatefulWidget {
  String qrCode;

  @override
  _QRCodeScanScreenState createState() => _QRCodeScanScreenState();
}

class _QRCodeScanScreenState extends State<QRCodeScanScreen> {
  void onTapped() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode("Green", "Cancel", true, ScanMode.QR);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("no scan"),
            ElevatedButton(
              onPressed: onTapped,
              child: Text("scan"),
            ),
          ],
        ),
      ),
    );
  }
}
// String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//                                                     COLOR_CODE, 
//                                                     CANCEL_BUTTON_TEXT, 
//                                                     isShowFlashIcon, 
//                                                     scanMode);