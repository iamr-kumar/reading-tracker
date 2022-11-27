import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/theme/pallete.dart';

class BookSearch extends StatefulWidget {
  final bool? selectMultiple;

  const BookSearch({super.key, this.selectMultiple = false});

  @override
  State<BookSearch> createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  FeatherIcons.search,
                  color: Pallete.primaryBlue,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Pallete.textGreyLight,
                hintText: 'Search for a book',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView(
            children: const [
              Text('Hello'),
              Text('Hello'),
              Text('Hello'),
            ],
          )),
        ],
      ),
    );
  }
}
