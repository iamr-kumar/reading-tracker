import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reading_tracker/core/constants/firebase_constants.dart';
import 'package:reading_tracker/core/failure.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/providers/firebase_providers.dart';
import 'package:reading_tracker/utils/handle_time.dart';

final readingGoalRepositoryProvider =
    Provider((ref) => ReadingGoalRepository(ref.read(firestoreProvider)));

class ReadingGoalRepository {
  final FirebaseFirestore _firestore;

  ReadingGoalRepository(this._firestore);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid updateReadingGoal(
      {required String uid,
      String? bookUid,
      TimeOfDay? time,
      int? pages,
      int? minutes,
      int? type}) async {
    final fieldsToUpdate = <String, dynamic>{};
    if (bookUid != null) fieldsToUpdate['readingBook'] = bookUid;
    if (pages != null) fieldsToUpdate['pages'] = pages;
    if (minutes != null) fieldsToUpdate['minutes'] = minutes;
    if (type != null) fieldsToUpdate['type'] = type;
    if (time != null) fieldsToUpdate['readingTime'] = toTimestamp(time);

    try {
      return right(_users.doc(uid).update(fieldsToUpdate));
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
