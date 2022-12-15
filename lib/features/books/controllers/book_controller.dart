import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/books/repository/book_repository.dart';
import 'package:reading_tracker/models/book_model.dart';

final bookControllerProvider = StateNotifierProvider<BookController, BookState>(
    (ref) => BookController(ref.read(bookRepositoryProvider), ref));

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
}
