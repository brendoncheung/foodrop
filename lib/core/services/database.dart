import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/business_user_link.dart';
import 'package:foodrop/core/models/items_category.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<UserProfile> userClientStream(String uid);
  Future<void> setUser(UserProfile user);
  Stream<Business> businessStream({String businessUid});
  Stream<List<BusinessUserLink>> businessUserLinkStream({String userId});
  Future<void> setImage({File pickedImage, String userId});
  Stream<List<ItemsCategory>> itemsCategoryStream(
      {@required String businessId});
// Future<void> setJob(Job job);
  // Future<void> deleteJob(Job job);
  // Stream<List<Job>> jobsStream();
  // Stream<Job> jobStream({@required String jobId});
  // Future<void> setBusiness(Relationship relationship);
  // Future<void> setUser(UserClient user);
  // String test();
}

class FirestoreDatabase implements Database {
  String uid;
  FirestoreDatabase({this.uid});

  final _service = FirestoreService.instance;

  @override
  Stream<UserProfile> userClientStream(String uid) => _service.documentStream(
        path: APIPath.userById(uid: uid),
        builder: (data, documentId) => UserProfile.fromMap(data, uid),
      );

  @override
  Future<void> setUser(UserProfile user) async {
    // print("path: ${APIPath.user(uid: uid)}");
    // print("map: ${user.toMap()}");
    // print("uid is: $uid");
    await FirestoreService.instance.setData(
      path: APIPath.userById(uid: uid),
      data: user.toMap(), // return a user object in Map format
    );
  }

  Future<String> setImage({File pickedImage, String userId}) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(userId + '.jpg');
    await ref.putFile(pickedImage).whenComplete;
    final stringUrl = ref.getDownloadURL();
    print(stringUrl);
    return stringUrl;
  }

  @override
  Stream<Business> businessStream({
    String businessUid,
  }) =>
      _service.documentStream(
        path: APIPath.businessById(uid: businessUid),
        builder: (data, documentId) => Business.fromMap(data, businessUid),
      );

  @override
  Stream<List<BusinessUserLink>> businessUserLinkStream({String userId}) =>
      _service.collectionStream<BusinessUserLink>(
          path: APIPath.businessUserLink(),
          queryBuilder: userId != null
              ? (query) => query.where('userId', isEqualTo: userId)
              : null,
          builder: (data, documentID) {
            print(documentID);
            return BusinessUserLink.fromMap(data, documentID);
          });

  @override
  Stream<List<ItemsCategory>> itemsCategoryStream(
          {@required String businessId}) =>
      _service.collectionStream<ItemsCategory>(
          path: APIPath.businessCategories(businessId: businessId),
          // queryBuilder: userId != null
          //     ? (query) => query.where('userId', isEqualTo: userId)
          //     : null,
          builder: (data, documentID) {
            print(documentID);
            return ItemsCategory.fromMap(data, documentID);
          });
}
//
// String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
//
// class FirestoreDatabase implements Database {
//   // FirestoreDatabase({@required this.uid}) : assert(uid != null);
//   // final String uid;
//   // // final UserProfile userProfile;
//   //
//   final _service = FirestoreService.instance;
//   //
//   // @override
//   // Future<void> setBusiness(Relationship relationship) => _service.setData(
//   //   path: APIPath.business(uid, relationship.business.id),
//   //   data: relationship.toMap(),
//   // );
//   //
//   // // @override
//   // // Stream<List<Business>> businessesStream() => _service.collectionStream(
//   // //       path: APIPath.businesses(uid),
//   // //       builder: (data, documentId) => Business.fromMap(data, documentId),
//   // //     );
//   //
//   // @override
//   // Future<void> setJob(Job job) => _service.setData(
//   //   path: APIPath.job(uid, job.id),
//   //   data: job.toMap(),
//   // );
//   @override
//   // Future<void> setUser(Job job) => _service.setData(
//   //       path: APIPath.job(uid, job.id),
//   //       data: job.toMap(),
//   //     );
//
//   //
//   // @override
//   // Future<void> deleteJob(Job job) async {
//   //   // delete where entry.jobId == job.jobId
//   //   final allEntries = await entriesStream(job: job).first;
//   //   for (Entry entry in allEntries) {
//   //     if (entry.jobId == job.id) {
//   //       await deleteEntry(entry);
//   //     }
//   //   }
//   //   // delete job
//   //   await _service.deleteData(path: APIPath.job(uid, job.id));
//   // }
//   //
//   // @override
//   // Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
//   //   path: APIPath.job(uid, jobId),
//   //   builder: (data, documentId) => Job.fromMap(data, documentId),
//   // );
//   //
//   // @override
//   // Stream<List<Job>> jobsStream() => _service.collectionStream(
//   //   path: APIPath.jobs(uid),
//   //   builder: (data, documentId) => Job.fromMap(data, documentId),
//   // );
//   //
//   // @override
//   // Future<void> setEntry(Entry entry) => _service.setData(
//   //   path: APIPath.entry(uid, entry.id),
//   //   data: entry.toMap(),
//   // );
//   //
//   // @override
//   // Future<void> deleteEntry(Entry entry) => _service.deleteData(
//   //   path: APIPath.entry(uid, entry.id),
//   // );
//   //
//   // @override
//   // Stream<List<Entry>> entriesStream({Job job}) =>
//   //     _service.collectionStream<Entry>(
//   //       path: APIPath.entries(uid),
//   //       queryBuilder: job != null
//   //           ? (query) => query.where('jobId', isEqualTo: job.id)
//   //           : null,
//   //       builder: (data, documentID) => Entry.fromMap(data, documentID),
//   //       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
//   //     );
// }
