import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidgetFactory {
  Widget makeQRCodeWidgetWithUuid(String uuid) {
    return QrImage(
      size: 300,
      data: uuid,
    );
  }
}
