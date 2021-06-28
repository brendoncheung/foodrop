import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidgetFactory {
  Widget makeQRCodeWidget(
    QRTransaction transaction,
  ) {
    return QrImage(
      data: transaction.toMap().toString(),
    );
  }
}
