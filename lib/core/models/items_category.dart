import 'package:flutter/material.dart';
import '../services/database/utilities.dart';

class ItemsCategory {
  ItemsCategory({String docId = "", this.name = "", @required this.businessId, DateTime creationDateTime, this.index = 1, this.isActive = true, DateTime lastUpdate})
      : creationDateTime = creationDateTime ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now(),
        docId = lastUpdate ?? Utilities.documentIdFromCurrentDate();
  String docId;
  String name;
  int index;
  String businessId;
  DateTime lastUpdate;
  bool isActive;
  DateTime creationDateTime;

  ItemsCategory.fromMap(Map<String, dynamic> data, String docId)
      : docId = docId,
        name = data['name'],
        index = data['index'],
        businessId = data['businessId'],
        creationDateTime = DateTime.parse(data['creationDateTime'].toDate().toString()),
        lastUpdate = DateTime.parse(data['lastUpdate'].toDate().toString()),
        isActive = data['isActive'];
  // lastUpdate = data['lastUpdate'],
  // creationDateTime = data['creationDateTime'];
  // DateTime.parse(timestamp.toDate().toString())

  Map<String, dynamic> toMap() {
    return {
      'docId': docId ?? docId,
      'name': name ?? name,
      'index': index ?? index,
      'businessId': businessId ?? businessId,
      'lastUpdate': lastUpdate ?? lastUpdate,
      'isActive': isActive ?? isActive,
      'creationDateTime': creationDateTime ?? creationDateTime
    };
  }
}
