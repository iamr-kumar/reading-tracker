// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/utils/handle_time.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final TimeOfDay? readingTime;
  final String? photoURL;
  final int? pages;
  final int? minutes;
  final GoalType? type;
  final String? readingBook;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.readingTime,
    this.photoURL,
    this.pages,
    this.minutes,
    this.type,
    this.readingBook,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    TimeOfDay? readingTime,
    String? photoURL,
    int? pages,
    int? minutes,
    GoalType? type,
    String? readingBook,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      readingTime: readingTime ?? this.readingTime,
      photoURL: photoURL ?? this.photoURL,
      pages: pages ?? this.pages,
      minutes: minutes ?? this.minutes,
      type: type ?? this.type,
      readingBook: readingBook ?? this.readingBook,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'readingTime': readingTime != null ? toTimestamp(readingTime!) : null,
      'photoURL': photoURL,
      'pages': pages,
      'minutes': minutes,
      'type': type,
      'readingBook': readingBook,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      readingTime: map['readingTime'] != null
          ? fromTimestamp(map['readingTime'] as Timestamp)
          : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      pages: map['pages'] != null ? map['pages'] as int : null,
      minutes: map['minutes'] != null ? map['minutes'] as int : null,
      type: map['type'] != null ? GoalType.values[map['type']] : null,
      readingBook:
          map['readingBook'] != null ? map['readingBook'] as String : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, readingTime: $readingTime, photoURL: $photoURL, pages: $pages, minutes: $minutes, type: $type, readingBook: $readingBook)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.readingTime == readingTime &&
        other.photoURL == photoURL &&
        other.pages == pages &&
        other.minutes == minutes &&
        other.type == type &&
        other.readingBook == readingBook;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        readingTime.hashCode ^
        photoURL.hashCode ^
        pages.hashCode ^
        minutes.hashCode ^
        type.hashCode ^
        readingBook.hashCode;
  }
}
