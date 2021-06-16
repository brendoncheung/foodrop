import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/menu.dart';

class MenuRepository {
  FirebaseFirestore _store;

  MenuRepository(FirebaseFirestore store) {
    this._store = store;
  }

  Stream<List<Menu>> get meals {
    var snapshot = _store.collection('menu').snapshots();
    return snapshot.map((event) {
      return event.docs.map((e) => Menu.fromMap(e.data())).toList();
    });
  }
}
    // var snapshot = fs.collection('restaurants').doc(vendorId).collection('menus').snapshots();
    // return snapshot.map<List<VendorMenuItem>>((event) {
    //   return event.docs.map((e) {
    //     return VendorMenuItem.fromMap(e.data());
    //   }).toList();