import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/books/repository/book_repository.dart';
import 'package:reading_tracker/features/goal/repository/reading_goal_repository.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

final bookControllerProvider = StateNotifierProvider<BookController, BookState>(
    (ref) => BookController(ref.read(bookRepositoryProvider), ref));

final booksProvider = StreamProvider.autoDispose<List<Book>>((ref) {
  final controller = ref.watch(bookControllerProvider.notifier);
  return controller.getAllBooks();
});

class BookState {
  final Book? currentlyReading;
  final List<Book>? books;
  final bool isLoading;
  final String? error;

  BookState(
      {this.currentlyReading,
      this.books = const [],
      this.isLoading = true,
      this.error});

  BookState copyWith({
    Book? currentlyReading,
    List<Book>? books,
    bool? isLoading,
    String? error,
  }) {
    return BookState(
      currentlyReading: currentlyReading ?? this.currentlyReading,
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class BookController extends StateNotifier<BookState> {
  final BookRepository _bookRepository;
  final Ref _ref;

  BookController(this._bookRepository, this._ref) : super(BookState()) {
    getCurrentlyReading();
  }

  void getCurrentlyReading() async {
    state = state.copyWith(isLoading: true);
    final user = _ref.read(userProvider);
    final book = await _bookRepository.getBook(user!.readingBook!);
    book.fold((l) {
      state = state.copyWith(error: l.message, isLoading: false);
    }, (userBook) {
      state = state.copyWith(currentlyReading: userBook, isLoading: false);
    });
  }

  Stream<List<Book>> getAllBooks() {
    return _bookRepository.getAllBooks();
  }

  Stream<List<Book>> getBooksByStatus(BookStatus status) {
    return _bookRepository.getBooksByStatus(status);
  }

  void addBook(
      BuildContext context, Book book, int status, String? progress) async {
    book = book.copyWith(status: BookStatus.values[status]);

    if (progress != null && status == 1) {
      book = book.copyWith(progress: int.parse(progress));
    }
    final newBook = await _ref.read(bookRepositoryProvider).addBook(book);

    newBook.fold((l) => showSnackBar(context, l.message), (r) {
      final message =
          'Book added to ${describeStatusEnum(BookStatus.values[status])}';
      showSnackBar(context, message);
    });
  }
}
