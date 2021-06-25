import 'dart:convert';
import 'package:flutter/material.dart';

class Review {
  String title;
  String comment;
  String userId;
  String uid;
  DateTime creationDate;
  int likes;
  Review({
    @required this.title,
    @required this.comment,
    @required this.userId,
    @required this.uid,
    @required this.creationDate,
    @required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'comment': comment,
      'userId': userId,
      'uid': uid,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      title: map['title'],
      comment: map['comment'],
      userId: map['userId'],
      uid: map['uid'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      likes: map['likes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(title: $title, comment: $comment, userId: $userId, uid: $uid, creationDate: $creationDate, likes: $likes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review && other.title == title && other.comment == comment && other.userId == userId && other.uid == uid && other.creationDate == creationDate && other.likes == likes;
  }

  @override
  int get hashCode {
    return title.hashCode ^ comment.hashCode ^ userId.hashCode ^ uid.hashCode ^ creationDate.hashCode ^ likes.hashCode;
  }
}
