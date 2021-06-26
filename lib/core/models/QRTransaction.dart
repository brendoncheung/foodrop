import 'dart:convert';
import 'package:flutter/material.dart';

class QRTransaction {
  final String businessId;
  final String creatorId;
  final String dollarAmountTransacted;
  final String transactionId;
  final String recipientId;
  QRTransaction({
    @required this.businessId,
    @required this.creatorId,
    @required this.dollarAmountTransacted,
    @required this.transactionId,
    @required this.recipientId,
  });

  QRTransaction copyWith({
    String businessId,
    String creatorId,
    String dollarAmountTransacted,
    String transactionId,
    String recipientId,
  }) {
    return QRTransaction(
      businessId: businessId ?? this.businessId,
      creatorId: creatorId ?? this.creatorId,
      dollarAmountTransacted: dollarAmountTransacted ?? this.dollarAmountTransacted,
      transactionId: transactionId ?? this.transactionId,
      recipientId: recipientId ?? this.recipientId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'creatorId': creatorId,
      'dollarAmountTransacted': dollarAmountTransacted,
      'transactionId': transactionId,
      'recipientId': recipientId,
    };
  }

  factory QRTransaction.fromMap(Map<String, dynamic> map) {
    return QRTransaction(
      businessId: map['businessId'],
      creatorId: map['creatorId'],
      dollarAmountTransacted: map['dollarAmountTransacted'],
      transactionId: map['transactionId'],
      recipientId: map['recipientId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QRTransaction.fromJson(String source) => QRTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QRTransaction(businessId: $businessId, creatorId: $creatorId, dollarAmountTransacted: $dollarAmountTransacted, transactionId: $transactionId, recipientId: $recipientId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRTransaction &&
        other.businessId == businessId &&
        other.creatorId == creatorId &&
        other.dollarAmountTransacted == dollarAmountTransacted &&
        other.transactionId == transactionId &&
        other.recipientId == recipientId;
  }

  @override
  int get hashCode {
    return businessId.hashCode ^ creatorId.hashCode ^ dollarAmountTransacted.hashCode ^ transactionId.hashCode ^ recipientId.hashCode;
  }
}
