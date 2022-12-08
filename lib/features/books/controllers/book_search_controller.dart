import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/books/repository/book_repository.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

final bookControllerProvider =
    StateNotifierProvider<BookController, BookSelectionState>(
        (ref) => BookController(ref.watch(bookRepositoryProvider)));

class BookSelectionState {
  final Book? book;
  final List<Book> searchedBooks;
  final bool isLoading;

  BookSelectionState({
    this.book,
    this.searchedBooks = const [],
    this.isLoading = false,
  });

  BookSelectionState copyWith({
    Book? book,
    List<Book>? searchedBooks,
    bool? isLoading,
  }) {
    return BookSelectionState(
      book: book ?? this.book,
      searchedBooks: searchedBooks ?? this.searchedBooks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookController extends StateNotifier<BookSelectionState> {
  final BookRepository _bookRepository;

  BookController(this._bookRepository) : super(BookSelectionState());

  void searchBooks(String query, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final books = await _bookRepository.searchBooks(query);
    books.fold((l) => showSnackBar(context, l.message), (books) {
      state = state.copyWith(searchedBooks: books, isLoading: false);
    });
  }

  void selectBook(Book book) {
    state = state.copyWith(book: book);
  }
}
