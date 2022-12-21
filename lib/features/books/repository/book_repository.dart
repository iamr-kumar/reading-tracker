import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:reading_tracker/core/config/keys.dart';
import 'package:reading_tracker/core/constants/firebase_constants.dart';
import 'package:reading_tracker/core/failure.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/providers/firebase_providers.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) =>
    BookRepository(ref.read(firestoreProvider), ref.read(userProvider)!.uid));

class BookRepository {
  final FirebaseFirestore _firestore;
  final String uid;

  BookRepository(this._firestore, this.uid);

  CollectionReference get _books => _firestore
      .collection(FirebaseConstants.usersCollection)
      .doc(uid)
      .collection(FirebaseConstants.booksCollection);

  FutureEither<List<Book>> searchBooks(String query) async {
    String apiKey;
    if (defaultTargetPlatform == TargetPlatform.android) {
      apiKey = Keys.API_KEY_ANDROID;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      apiKey = Keys.API_KEY_IOS;
    } else {
      apiKey = Keys.API_KEY;
    }
    final response = await get(
      Uri.parse(
        '${Keys.API_URI}$query$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      List<dynamic> books = body['items'];

      return right(books
          .map(
              (book) => Book.fromMap({...book['volumeInfo'], "id": book["id"]}))
          .toList());
    } else {
      throw left(Failure('Failed to load books'));
    }
  }

  FutureVoid addBook(Book book) async {
    try {
      return right(_books.doc(book.id).set(book.toMap()));
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<Book> getBook(String id) async {
    try {
      final book = await _books.doc(id).get();
      return right(Book.fromMap(book.data() as Map<String, dynamic>));
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  Stream<List<Book>> getAllBooks() {
    return _books.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<List<Book>> getBooksByStatus(BookStatus status) {
    return _books
        .where('status', isEqualTo: status.index)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  FutureVoid updateBook(Book book) async {
    try {
      return right(_books.doc(book.id).update(book.toMap()));
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
