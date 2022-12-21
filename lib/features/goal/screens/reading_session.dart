import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/goal_dialog.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/goal/screens/reading_timer.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/utils/minute_to_page.dart';

class ReadingSessionScreen extends ConsumerStatefulWidget {
  const ReadingSessionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReadingSessionScreenState();
}

class _ReadingSessionScreenState extends ConsumerState<ReadingSessionScreen> {
  int? _pages;
  int? _minutes;
  final TextEditingController _targetController = TextEditingController();

  int type = 1;

  @override
  void dispose() {
    super.dispose();
    _targetController.dispose();
  }

  void updateType(int? value) {
    if (value != null) {
      setState(() {
        type = value;
      });
    }
  }

  void updateTarget(String text) {
    if (type == 1) {
      setState(() {
        _pages = int.parse(text);
        _minutes = getMinutesFromPage(_pages!);
      });
    } else {
      setState(() {
        _minutes = int.parse(text);
        _pages = getPageFromMinutes(_minutes!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    final readingTimeInSeconds =
        _minutes != null ? _minutes! * 60 : user.minutes! * 60;
    final currentlyReading = ref.read(bookControllerProvider).currentlyReading!;

    final minutes = user.minutes ?? getMinutesFromPage(user.pages!);

    final pages = user.pages ?? getPageFromMinutes(user.minutes!);

    void editTarget() async {
      await showDialog(
          context: context,
          builder: (context) {
            return showGoalDialog(
                context: context,
                targetController: _targetController,
                type: type,
                updateType: updateType);
          });

      if (_targetController.text.isNotEmpty) {
        updateTarget(_targetController.text);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Start Reading', style: AppStyles.headingFour)),
                const SizedBox(height: 40),
                ReadingTimer(
                  goalTime: readingTimeInSeconds,
                ),
                const SizedBox(height: 20),
                Stack(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Pallete.textGreyLight, width: 4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Time', style: AppStyles.subtext),
                            Text('Pages', style: AppStyles.subtext),
                            Text('Book', style: AppStyles.subtext)
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${_minutes != null ? _minutes.toString() : minutes.toString()} minutes',
                                style: AppStyles.highlightedSubtext),
                            Text(
                                _pages != null
                                    ? _pages.toString()
                                    : pages.toString(),
                                style: AppStyles.highlightedSubtext),
                            Text(currentlyReading.title,
                                style: AppStyles.highlightedSubtext),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: editTarget,
                      child: const CircleAvatar(
                        backgroundColor: Pallete.primaryBlue,
                        child: Icon(
                          FeatherIcons.edit,
                        ),
                      ),
                    ),
                  )
                ])
              ],
            )),
      ),
    );
  }
}
