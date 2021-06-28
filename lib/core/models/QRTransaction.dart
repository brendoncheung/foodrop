import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QRTransaction {
  final String businessId;
  final String recipientId;
  final String creatorId;
  final bool isTransactionCompleted = false;
  final num dollarAmountTransacted;
  QRTransaction({
    @required this.businessId,
    @required this.recipientId,
    @required this.creatorId,
    @required this.dollarAmountTransacted,
  });
  final DateTime creationTime = DateTime.now();
  final DateTime completeTime = DateTime.now();

  QRTransaction copyWith({
    String businessId,
    String recipientId,
    String creatorId,
    num dollarAmountTransacted,
  }) {
    return QRTransaction(
      businessId: businessId ?? this.businessId,
      recipientId: recipientId ?? this.recipientId,
      creatorId: creatorId ?? this.creatorId,
      dollarAmountTransacted: dollarAmountTransacted ?? this.dollarAmountTransacted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'recipientId': recipientId,
      'creatorId': creatorId,
      'dollarAmountTransacted': dollarAmountTransacted,
      'isTransactionCompleted': isTransactionCompleted,
      'creationTime': creationTime,
      'compeleteTime': completeTime,
    };
  }

  factory QRTransaction.fromMap(Map<String, dynamic> map) {
    return QRTransaction(
      businessId: map['businessId'],
      recipientId: map['recipientId'],
      creatorId: map['creatorId'],
      dollarAmountTransacted: map['dollarAmountTransacted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QRTransaction.fromJson(String source) => QRTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QRTransaction(businessId: $businessId, recipientId: $recipientId, creatorId: $creatorId, dollarAmountTransacted: $dollarAmountTransacted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRTransaction && other.businessId == businessId && other.recipientId == recipientId && other.creatorId == creatorId && other.dollarAmountTransacted == dollarAmountTransacted;
  }

  @override
  int get hashCode {
    return businessId.hashCode ^ recipientId.hashCode ^ creatorId.hashCode ^ dollarAmountTransacted.hashCode;
  }
}
