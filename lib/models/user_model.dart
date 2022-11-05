// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final DateTime? readingTime;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.readingTime,
    this.photoURL,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? readingTime,
    String? photoURL,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      readingTime: readingTime ?? this.readingTime,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'readingTime': readingTime?.millisecondsSinceEpoch,
      'photoURL': photoURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      readingTime: map['readingTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['readingTime'] as int)
          : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, readingTime: $readingTime, photoURL: $photoURL)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.readingTime == readingTime &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        readingTime.hashCode ^
        photoURL.hashCode;
  }
}
