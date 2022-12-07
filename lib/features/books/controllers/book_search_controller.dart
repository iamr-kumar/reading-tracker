import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:reading_tracker/core/config/keys.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookSearchProvider = StateNotifierProvider<BookSearchController, bool>(
    (ref) => BookSearchController());

class BookSearchController extends StateNotifier<bool> {
  BookSearchController() : super(false);

  Future<List<Book>> searchBooks(String query) async {
    state = true;
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
    state = false;
    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      List<dynamic> books = body['items'];

      return books
          .map(
              (book) => Book.fromMap({...book['volumeInfo'], "id": book["id"]}))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
