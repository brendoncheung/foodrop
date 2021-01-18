import 'package:flutter/foundation.dart';

class VendorMenuItem {
  final String name;
  final String description;
  final double price;

  VendorMenuItem({
    @required this.name,
    @required this.description,
    @required this.price,
  });

  VendorMenuItem.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        price = map['price'];
}