import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/QRTransaction.dart';
import 'package:foodrop/core/models/business.dart';

class QRTransactionReposity {
  final FirebaseFirestore store;
  final String businessId;

  QRTransactionReposity({
    @required this.store,
    @required this.businessId,
  });

  Future<List<QRTransaction>> fetchAllTransactions() async {
    var querySnapshot = await store.collection('business').doc(businessId).collection('transaction').get();
    return await querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data()));
  }

  Future<List<QRTransaction>> fetchAllTransactionsByUserId(String id) async {
    var querySnapshot = await store.collection('business').doc(businessId).collection('transaction').where(businessId, isEqualTo: id).get();
    return await querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data()));
  }
}
