import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/qr_Intermediate.dart';
import '../../models/qr_transaction.dart';

class QRTransactionRepository {
  final FirebaseFirestore store;

  QRTransactionRepository({
    @required this.store,
  });

  CollectionReference _getQRTransactionPath(String businessId) {
    return store.collection('businesses').doc(businessId).collection('transaction');
    // .withConverter<QRTransaction>(
    //       fromFirestore: (snapshot, _) => QRTransaction.fromMap(snapshot.data()),
    //       toFirestore: (model, _) => model.toMap(),
    //     );
  }

  CollectionReference _getQRIntermediateTransactionPath() {
    return store.collection('qrIntermediateTransaction');
  }

  Future<String> addTransaction(QRTransaction transaction) async {
    var result = await _getQRTransactionPath(transaction.businessId).add(transaction.toMap());
    return result.id;
  }

  Future<String> addIntermediateTransaction(QRIntermediateTransaction intermediateTransaction) async {
    var result = await _getQRIntermediateTransactionPath().add(intermediateTransaction.toMap());
    return result.id;
  }

  Future<void> updateTransactionWithRecepientId(QRIntermediateTransaction transaction, String recepientId) async {
    var query = _getQRTransactionPath(transaction.businessId).where('uuid', isEqualTo: transaction.uuid);
    var id = (await query.get()).docs.first.id;

    _getQRTransactionPath(transaction.businessId).doc(id).update({"recipientId": recepientId});
  }

  Stream<List<QRTransaction>> fetchAllTransactionsStream(String businessId, {bool live = false}) {
    // TODO: use withConverter
    var querySnapshot = _getQRTransactionPath(businessId).snapshots();
    return querySnapshot.map<List<QRTransaction>>((event) {
      return event.docs.map((e) {
        return QRTransaction.fromMap(e.data());
      });
    });
  }

  Stream<QRTransaction> fetchQRTransactionByUuidStream({String businessId, String uuid}) {
    return _getQRTransactionPath(businessId).where('uuid', isEqualTo: uuid).snapshots().map(
          (event) => QRTransaction.fromMap(
            event.docs.first.data(),
          ),
        );
  }

  Future<List<QRTransaction>> fetchAllTransactions(String businessId) async {
    // TODO: use withConverter
    var querySnapshot = await _getQRTransactionPath(businessId).get();
    return querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data())).toList();
  }

  Future<List<QRTransaction>> fetchAllTransactionsByUserId(String businessId, String userId) async {
    // TODO: use withConverter
    var querySnapshot = await _getQRTransactionPath(businessId).where(businessId, isEqualTo: userId).get();
    return await querySnapshot.docs.map((e) => QRTransaction.fromMap(e.data()));
  }
}
