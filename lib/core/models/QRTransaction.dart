import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QRTransaction {
  final String businessId;
  final String recipientId;
  final String creatorId;
  final bool isTransactionCompleted = false;
  final double dollarAmountTransacted;
  final String uuid;
  QRTransaction({
    @required this.businessId,
    @required this.recipientId,
    @required this.creatorId,
    @required this.dollarAmountTransacted,
    @required this.uuid,
  });
  final DateTime creationTime = DateTime.now();
  final DateTime completeTime = DateTime.now();

  QRTransaction copyWith({
    String businessId,
    String recipientId,
    String creatorId,
    num dollarAmountTransacted,
    String uuid,
  }) {
    return QRTransaction(
      businessId: businessId ?? this.businessId,
      recipientId: recipientId ?? this.recipientId,
      creatorId: creatorId ?? this.creatorId,
      dollarAmountTransacted: dollarAmountTransacted ?? this.dollarAmountTransacted,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'recipientId': recipientId,
      'creatorId': creatorId,
      'dollarAmountTransacted': dollarAmountTransacted,
      'uuid': uuid,
    };
  }

  factory QRTransaction.fromMap(Map<String, dynamic> map) {
    return QRTransaction(
      businessId: map['businessId'],
      recipientId: map['recipientId'],
      creatorId: map['creatorId'],
      dollarAmountTransacted: map['dollarAmountTransacted'],
      uuid: map['uuid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QRTransaction.fromJson(String source) => QRTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QRTransaction(businessId: $businessId, recipientId: $recipientId, creatorId: $creatorId, dollarAmountTransacted: $dollarAmountTransacted, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRTransaction &&
        other.businessId == businessId &&
        other.recipientId == recipientId &&
        other.creatorId == creatorId &&
        other.dollarAmountTransacted == dollarAmountTransacted &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return businessId.hashCode ^ recipientId.hashCode ^ creatorId.hashCode ^ dollarAmountTransacted.hashCode ^ uuid.hashCode;
  }
}
