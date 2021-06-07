import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/api_path.dart';

import '../firestore_service.dart';

class UserProfileRepository {
  FirebaseFirestore _store;

  UserProfileRepository(FirebaseFirestore store) {
    this._store = store;
  }

  Future<UserProfile> fetchUserProfileById(String id) async {
    FirestoreService.instance.documentStream<UserProfile>(
        path: APIPath.userById(uid: id),
        builder: (data, id) {
          return UserProfile.fromMap(data, id);
        });
  }
}