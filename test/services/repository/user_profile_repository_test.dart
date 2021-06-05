import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foodrop/core/services/repositories/user_profile_repository.dart';
import 'package:foodrop/core/models/UserProfile.dart';

void main() {
  test('user repo should return userprofile', () async {
    Firebase.initializeApp();
    UserProfileRepository repo = UserProfileRepository(FirebaseFirestore.instance);
    UserProfile user = await repo.fetchUserProfileById("0iiZSjE4JLeGJlALfFjuNOTIYCx1");
    print("testing");
    expect(user.emailAddress, "paul@paul.com");
  });
}
