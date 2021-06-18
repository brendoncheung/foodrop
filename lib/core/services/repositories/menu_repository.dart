import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/menu.dart';

class ItemRepository {
  FirebaseFirestore _store;

  ItemRepository(FirebaseFirestore store) {
    this._store = store;
  }

  Stream<List<Item>> get itemsLive {
    var snapshot = _store.collection('menu').snapshots();
    return snapshot.map((event) {
      return event.docs.map((e) => Item.fromMap(e.data())).toList();
    });
  }

  Future<Item> getItemById(String id) {
    return _store.collection('menu').doc(id).get().then((value) {
      var item = Item.fromMap(value.data());
      print(item);
      return Item.fromMap(value.data());
    });
  }

  Future<bool> updateItem(Item menu) {}

  Future<bool> deleteItemById(String id) {}
}
