import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';
import 'image_repository.dart';

class ItemRepository {
  FirebaseFirestore _store;
  ImageRepository imageRepository;

  ItemRepository(FirebaseFirestore store) {
    this._store = store;
  }

  Stream<List<Item>> get itemsLive {
    var snapshot = _store.collection('items').snapshots();
    return snapshot.map((event) {
      return event.docs.map((e) => Item.fromMap(e.data(), e.id)).toList();
    });
  }

  Future<List<Item>> get items {
    return _store.collection('items').get().then((value) {
      return value.docs.map((e) => Item.fromMap(e.data(), e.id)).toList();
    });
  }

  Future<List<Item>> getItemsFromFollowedBusinessId(String userId) {
    return _store.collection('items').get().then((value) {
      return value.docs.map((e) => Item.fromMap(e.data(), e.id)).toList();
    });
  }

  Future<Item> getItemById(String id) {
    return _store.collection('menu').doc(id).get().then((value) {
      return Item.fromMap(value.data(), value.id);
    });
  }

  Future<bool> updateItem(Item item) {}

  Future<bool> deleteItemById(String id) {}
}
