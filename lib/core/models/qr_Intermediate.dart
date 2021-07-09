import 'dart:convert';

import 'package:flutter/material.dart';

class QRIntermediateTransaction {
  final String uuid;
  final String businessId;
  QRIntermediateTransaction({
    @required this.uuid,
    @required this.businessId,
  });
  final DateTime creationDate = DateTime.now();

  QRIntermediateTransaction copyWith({
    String uuid,
    String businessId,
  }) {
    return QRIntermediateTransaction(
      uuid: uuid ?? this.uuid,
      businessId: businessId ?? this.businessId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'businessId': businessId,
    };
  }

  factory QRIntermediateTransaction.fromMap(Map<String, dynamic> map) {
    return QRIntermediateTransaction(
      uuid: map['uuid'],
      businessId: map['businessId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QRIntermediateTransaction.fromJson(String source) => QRIntermediateTransaction.fromMap(json.decode(source));

  @override
  String toString() => 'QRIntermediateTransaction(uuid: $uuid, businessId: $businessId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRIntermediateTransaction && other.uuid == uuid && other.businessId == businessId;
  }

  @override
  int get hashCode => uuid.hashCode ^ businessId.hashCode;
}
