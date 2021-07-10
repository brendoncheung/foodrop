import 'package:flutter/material.dart';
import 'promo/edit_promo.dart';

class PromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Align(child: Text("Promotion")),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditPromo.show(context),
          )
        ],
      ),
    );
  }
}
