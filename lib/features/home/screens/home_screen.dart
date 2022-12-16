import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/core/widgets/book_info.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:reading_tracker/utils/handle_time.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    final greetingMessage = getGreetingMessage();

    final deviceHeight = MediaQuery.of(context).size.height;

    final readingGoal = user.pages ?? user.minutes;

    final bookData = ref.watch(bookControllerProvider);

    final currentRead = bookData.currentlyReading;

    final percentComplete = currentRead != null
        ? currentRead.progress! / currentRead.pageCount
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
              Card(
                elevation: 5,
                shadowColor: Pallete.textGreyLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: SizedBox(
                    height: deviceHeight * 0.35,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today\'s progress',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Pallete.textGrey),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 72,
                                    color: Pallete.textGrey,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' / $readingGoal',
                                style: const TextStyle(
                                    fontSize: 72,
                                    color: Pallete.primaryBlue,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Center(
                              child: Text(describeGoalTypeEnum(user.type!),
                                  style: AppStyles.bodyText)),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: CustomButton(
                                    text: 'Read Now', onPressed: () {}),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
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
                  ? const Expanded(child: Center(child: Loader()))
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
              LinearPercentIndicator(
                lineHeight: 8.0,
                percent: percentComplete,
                progressColor: Pallete.primaryBlue,
                animationDuration: 1000,
                animation: true,
                barRadius: const Radius.circular(12),
              ),
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
