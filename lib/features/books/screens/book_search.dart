import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/book_status_dialog.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/books/controllers/book_search_controller.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/theme/pallete.dart';

class BookSearch extends ConsumerStatefulWidget {
  final bool isNew;

  const BookSearch({super.key, this.isNew = true});

  @override
  ConsumerState<BookSearch> createState() => _BookSearchState();
}

class _BookSearchState extends ConsumerState<BookSearch> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  int status = 0;

  final TextEditingController _progressController = TextEditingController();

  void searchBooks(BuildContext context) async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref
          .read(bookSearchControllerProvider.notifier)
          .searchBooks(query, context);
    }
  }

  void _onSearchChanged(BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchBooks(context);
    });
  }

  void selectBook(Book book, BuildContext context) {
    ref
        .read(bookSearchControllerProvider.notifier)
        .selectBook(book, status, _progressController.text);
    Navigator.of(context).pop();
  }

  void addBook(Book book, BuildContext context) {
    ref
        .read(bookControllerProvider.notifier)
        .addBook(context, book, status, _progressController.text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _progressController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void setStatus(int? value) {
    if (value != null) {
      setState(() {
        status = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(bookSearchControllerProvider).isLoading;
    List<Book> books = ref.watch(bookSearchControllerProvider).searchedBooks;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _searchController,
            onChanged: (value) => _onSearchChanged(context),
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
          isLoading
              ? const Loader()
              : _searchController.text.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image.network(
                                  books[index].thumbnail ??
                                      'https://via.placeholder.com/150',
                                  width: 50),
                              title: Text(books[index].title),
                              subtitle: Text(books[index].authors.join(', ')),
                              trailing: TextButton(
                                  child: const Text('Add'),
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return showBookStatusDialog(
                                              context: context,
                                              page: books[index].pageCount,
                                              progressController:
                                                  _progressController,
                                              status: status,
                                              updateStatus: setStatus,
                                              isNew: widget.isNew,
                                              onComplete: () => widget.isNew
                                                  ? selectBook(
                                                      books[index], context)
                                                  : addBook(
                                                      books[index], context));
                                        });
                                  }),
                            );
                          }),
                    )
                  : const Center(
                      child: Text('What are you reading right now?')),
        ],
      ),
    );
  }
}
