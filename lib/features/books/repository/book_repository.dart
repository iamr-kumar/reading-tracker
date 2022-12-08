import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:reading_tracker/core/config/keys.dart';
import 'package:reading_tracker/core/failure.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/models/book_model.dart';

final bookRepositoryProvider =
    Provider<BookRepository>((ref) => BookRepository());

class BookRepository {
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
}
