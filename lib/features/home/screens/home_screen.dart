import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reading_tracker/core/widgets/book_info.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/core/widgets/percent_progress_indicator.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/home/screens/progress_card.dart';
import 'package:reading_tracker/providers/notification_service_provider.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:reading_tracker/utils/handle_time.dart';

class HomeScreen extends ConsumerWidget {
  final ValueSetter<int> switchTab;
  const HomeScreen({super.key, required this.switchTab});

  void showNotification(WidgetRef ref, TimeOfDay? time) {
    if (time != null) {
      ref.read(notificationServiceProvider).sendScheduledNotification(
          'Notification Title', 'Notification Body', time);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    final greetingMessage = getGreetingMessage();

    final deviceHeight = MediaQuery.of(context).size.height;

    final bookData = ref.watch(bookControllerProvider);

    final currentRead = bookData.currentlyReading;

    final percentComplete = currentRead != null
        ? currentRead.progress / currentRead.pageCount
        : 0.0;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, right: 16, bottom: 8, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  user.photoURL != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '$greetingMessage, ${user.name.split(' ').first} 👋',
                    style: AppStyles.bodyText.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Pallete.primaryBlue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProgressCard(switchTab),
              const SizedBox(height: 16),
              Text(
                'Currently Reading',
                style: AppStyles.bodyText.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Pallete.textGrey),
              ),
              const SizedBox(height: 16),
              bookData.isLoading
                  ? const SizedBox(height: 100, child: Center(child: Loader()))
                  : currentRead == null
                      ? const Text(
                          'You are not currently reading anything',
                          style: AppStyles.bodyText,
                          textAlign: TextAlign.center,
                        )
                      : Center(
                          child:
                              BookInfo(book: currentRead, height: deviceHeight),
                        ),
              const SizedBox(height: 16),
              Center(child: PercentProgressIndicator(percent: percentComplete)),
              Center(
                heightFactor: 2,
                child: Text(
                  '${(percentComplete * 100).ceil()}% completed',
                  style: AppStyles.bodyText,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
