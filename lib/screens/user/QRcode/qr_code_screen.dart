import 'package:flutter/material.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: QrImage(
          data: "{sad,asd,a,sd,as,d,as,d,asd,,as,d,as,d,f,dsf,}",
          size: 100.0,
        ),
      ),
    );
  }
}
