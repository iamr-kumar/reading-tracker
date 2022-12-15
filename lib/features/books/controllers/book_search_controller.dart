import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/books/repository/book_repository.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

final bookSearchControllerProvider =
    StateNotifierProvider<BookSearchController, BookSelectionState>(
        (ref) => BookSearchController(ref.watch(bookRepositoryProvider)));

class BookSelectionState {
  final Book? selectedBook;
  final List<Book> searchedBooks;
  final bool isLoading;

  BookSelectionState({
    this.selectedBook,
    this.searchedBooks = const [],
    this.isLoading = false,
  });

  BookSelectionState copyWith({
    Book? book,
    List<Book>? searchedBooks,
    bool? isLoading,
  }) {
    return BookSelectionState(
      selectedBook: book ?? selectedBook,
      searchedBooks: searchedBooks ?? this.searchedBooks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookSearchController extends StateNotifier<BookSelectionState> {
  final BookRepository _bookRepository;

  BookSearchController(this._bookRepository) : super(BookSelectionState());

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