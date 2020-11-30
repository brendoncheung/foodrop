import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodrop/core/models/vendor/vendor_menu_item.dart';

class VendorMenuItemRepository {
  var fs = FirebaseFirestore.instance;

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

  Stream<List<VendorMenuItem>> getAllVendorMenuItems(String vendorId) {
    /*
      TODO: 
    whenever there is a single update a document inside a collection, you will get ALL documents back so cost will increase, 
    figure out how to only return the updated object instead of the whole collection

    */
    var snapshot = fs.collection('restaurants').doc(vendorId).collection('menus').snapshots(includeMetadataChanges: false);

    return snapshot.map<List<VendorMenuItem>>((event) {
      return event.docs.map((e) {
        return VendorMenuItem.fromMap(e.data());
      }).toList();
    });
  }

  List<VendorMenuItem> get allItems {
    return List.unmodifiable(_items);
  }

  int get itemCount {
    return _items.length;
  }

  void set addItem(VendorMenuItem item) {
    _items.add(item);
  }
}
