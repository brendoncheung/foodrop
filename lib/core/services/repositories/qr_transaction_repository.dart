import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/business.dart';

class QRTransactionRepository {
  final FirebaseFirestore store;

  QRTransactionRepository({
    @required this.store,
  });

  CollectionReference _getPath(String businessId) {
    return store.collection('businesses').doc(businessId).collection('transaction');
  }

  Future<String> addTransaction(QRTransaction transaction) async {
    var result = await _getPath(transaction.businessId).add(transaction.toMap());
    return result.id;
  }

  Future<List<QRTransaction>> fetchAllTransactions(String businessId) async {
    var querySnapshot = await _getPath(businessId).get();
    return await querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data()));
  }

  Future<List<QRTransaction>> fetchAllTransactionsByUserId(String businessId, String userId) async {
    var querySnapshot = await _getPath(businessId).where(businessId, isEqualTo: userId).get();
    return await querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data()));
  }
}
