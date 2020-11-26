import 'package:foodrop/core/models/vendor/vendor_menu_item.dart';

class VendorMenuItemRepository {
  final List<VendorMenuItem> _items = [
    VendorMenuItem(name: "Fried rice", description: "Shrimp and beef stirred with rice and eggs", price: 10.99),
    VendorMenuItem(name: "Steamed rice", description: "Just plain old steam rice", price: 10.99),
    VendorMenuItem(name: "Orange chicken", description: "Vinegar and sugar enough to make you diabetic", price: 10.99),
    VendorMenuItem(name: "Chicken soup", description: "Chicken boiled in water", price: 10.99),
    VendorMenuItem(name: "Stir fried ribs", description: "Shrimp pasted stir fried with pork ribs", price: 10.99),
  ];

  void addMenuItem(VendorMenuItem item) {
    if (item == null) {
      print("VendorMenuItemRepository hash: ${this.hashCode}");
      return;
    }

    _items.add(item);
  }

  List<VendorMenuItem> get allItems {
    return List.unmodifiable(_items);
  }

  int get itemCount {
    return _items.length;
  }
}
