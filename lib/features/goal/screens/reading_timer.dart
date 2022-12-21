import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/goal/controllers/reading_goal_controller.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/utils/minute_to_page.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

class ReadingTimer extends ConsumerStatefulWidget {
  final int goalTime;
  const ReadingTimer({
    super.key,
    required this.goalTime,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadingTimerState();
}

class _ReadingTimerState extends ConsumerState<ReadingTimer> {
  int minutes = 0;
  int seconds = 0;
  late DateTime startTime;
  Timer? timer;

  String getTime() {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 59) {
        minutes++;
        seconds = 0;
      } else {
        seconds++;
      }
      setState(() {
        startTime = DateTime.now();
      });
    });
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void completeSession() async {
    if (minutes <= 0) {
      showSnackBar(context, 'Read for a minute atleast');
      return;
    }
    timer?.cancel();
    final pages = getPageFromMinutes(minutes);

    final book = ref.read(bookControllerProvider).currentlyReading!;
    DateTime endTime = DateTime.now();
    ref
        .read(bookControllerProvider.notifier)
        .updateBookProgress(context, book, pages);
    ref.read(readingGoalControllerProvider.notifier).createNewLog(
        bookId: book.id,
        pages: pages == 0 ? 1 : pages,
        minutes: minutes,
        startTime: startTime,
        endTime: endTime,
        context: context);
    setState(() {
      minutes = 0;
      seconds = 0;
    });
  }

  Widget buildButtons() {
    final isRunning = timer != null && timer!.isActive;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: CustomButton(
              text: isRunning ? 'Pause' : 'Start',
              isCompact: true,
              onPressed: () {
                if (isRunning) {
                  pauseTimer();
                } else {
                  startTimer();
                }
              }),
        ),
        const SizedBox(width: 20),
        !isRunning && (minutes > 0 || seconds > 0)
            ? SizedBox(
                width: 120,
                child: CustomButton(
                    text: 'Done', isCompact: true, onPressed: completeSession),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTimeInSeconds = minutes * 60 + seconds;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: elapsedTimeInSeconds / widget.goalTime,
                    valueColor:
                        const AlwaysStoppedAnimation(Pallete.primaryBlue),
                    strokeWidth: 12,
                    backgroundColor: Pallete.textGreyLight,
                  ),
                  Center(
                    child: Text(getTime(),
                        style: AppStyles.headingOne.copyWith(fontSize: 54)),
                  )
                ],
              )),
        ),
        const SizedBox(height: 40),
        Center(child: buildButtons())
      ],
    );
  }
}
