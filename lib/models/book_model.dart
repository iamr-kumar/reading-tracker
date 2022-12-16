// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reading_tracker/core/type_defs.dart';

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publishedDate;
  final String description;
  final List<String>? categories;
  final String? thumbnail;
  final int pageCount;
  final BookStatus status;
  final int? progress;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.description,
    this.categories,
    required this.thumbnail,
    required this.pageCount,
    required this.status,
    this.progress,
  });

  Book copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? publishedDate,
    String? description,
    List<String>? categories,
    String? thumbnail,
    int? pageCount,
    BookStatus? status,
    int? progress,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      publishedDate: publishedDate ?? this.publishedDate,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      thumbnail: thumbnail ?? this.thumbnail,
      pageCount: pageCount ?? this.pageCount,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'authors': authors,
      'publishedDate': publishedDate,
      'description': description,
      'categories': categories,
      'thumbnail': thumbnail,
      'pageCount': pageCount,
      'status': status.index,
      'progress': progress,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"] ?? '',
      title: map['title'] as String,
      authors: List<String>.from(map['authors'] as List<dynamic>),
      publishedDate: map['publishedDate'] ?? '',
      description: map['description'] ?? '',
      categories: map['categories'] != null
          ? List<String>.from(map['categories'] as List<dynamic>)
          : null,
      thumbnail: map['imageLinks'] != null
          ? map['imageLinks']['thumbnail'] as String
          : map['thumbnail'] != null
              ? map['thumbnail'] as String
              : null,
      pageCount: map['pageCount'] ?? 0,
      status: BookStatus.values[map['status'] ?? 0],
      progress: map['progress'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, authors: $authors, publishedDate: $publishedDate, categories: $categories, thumbnail: $thumbnail, pageCount: $pageCount, status: $status, progress: $progress)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.authors, authors) &&
        other.publishedDate == publishedDate &&
        other.description == description &&
        listEquals(other.categories, categories) &&
        other.thumbnail == thumbnail &&
        other.pageCount == pageCount &&
        other.status == status &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        authors.hashCode ^
        publishedDate.hashCode ^
        description.hashCode ^
        categories.hashCode ^
        thumbnail.hashCode ^
        pageCount.hashCode ^
        status.hashCode ^
        progress.hashCode;
  }
}
