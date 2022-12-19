import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/goal/screens/reading_timer.dart';

class ReadingSessionScreen extends ConsumerWidget {
  const ReadingSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final readingTimeInSeconds = user!.minutes! * 60;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ReadingTimer(goalTime: readingTimeInSeconds)),
      ),
    );
  }
}
