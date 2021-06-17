import 'package:flutter/material.dart';

import 'edit_promo.dart';

class PromoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
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
