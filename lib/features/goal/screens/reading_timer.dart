import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:reading_tracker/theme/app_styles.dart';

class ReadingTimer extends StatefulWidget {
  final int goalTime;
  const ReadingTimer({super.key, required this.goalTime});

  @override
  State<ReadingTimer> createState() => _ReadingTimerState();
}

class _ReadingTimerState extends State<ReadingTimer> {
  int minutes = 0;
  int seconds = 0;
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
      setState(() {});
    });
  }

  void pauseTimer() {
    timer?.cancel();
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
                    text: 'Done',
                    isCompact: true,
                    onPressed: () {
                      timer?.cancel();
                      setState(() {
                        minutes = 0;
                        seconds = 0;
                      });
                    }),
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
        Align(
          alignment: Alignment.topLeft,
          child: Text('Start Reading',
              style: AppStyles.bodyText.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Pallete.primaryBlue)),
        ),
        const SizedBox(height: 40),
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
