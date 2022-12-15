// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';

class BookInfo extends StatelessWidget {
  final Book book;
  final double height;

  const BookInfo({
    Key? key,
    required this.book,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: NetworkImage(book.thumbnail!),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(book.title,
            style: AppStyles.subtext.copyWith(
                color: Pallete.primaryBlue, fontWeight: FontWeight.w500)),
        Text('by ${book.authors.join(', ')}', style: AppStyles.bodyText),
      ],
    );
  }
}
