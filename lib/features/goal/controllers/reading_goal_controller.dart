import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/goal/repository/reading_goal_repository.dart';
import 'package:reading_tracker/models/reading_log_model.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

final readingGoalControllerProvider =
    StateNotifierProvider<ReadingGoalController, bool>((ref) =>
        ReadingGoalController(ref.read(readingGoalRepositoryProvider), ref));

final todaysProgressProvider =
    StreamProvider.autoDispose<List<ReadingLog>>((ref) {
  return ref.read(readingGoalControllerProvider.notifier).getTodaysLogs();
});

class ReadingGoalController extends StateNotifier<bool> {
  final Ref _ref;
  final ReadingGoalRepository _readingGoalRepository;

  ReadingGoalController(this._readingGoalRepository, this._ref) : super(false);

  void createNewLog(
      {required String bookId,
      required int pages,
      required int minutes,
      required DateTime startTime,
      required DateTime endTime,
      required BuildContext context}) async {
    state = true;
    final userId = _ref.read(userProvider)!.uid;
    final readingLog = await _readingGoalRepository.createNewLog(
      userId: userId,
      bookId: bookId,
      pages: pages,
      minutes: minutes,
      start: startTime,
      end: endTime,
    );
    state = false;

    readingLog.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  Stream<List<ReadingLog>> getTodaysLogs() {
    final userId = _ref.read(userProvider)!.uid;
    return _readingGoalRepository.getTodaysLogs(userId);
  }

  Stream<List<ReadingLog>> getLogs() {
    final userId = _ref.read(userProvider)!.uid;
    return _readingGoalRepository.getLogs(userId);
  }
}
