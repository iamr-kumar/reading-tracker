import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/features/goal/controllers/reading_goal_controller.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:reading_tracker/theme/app_styles.dart';

class ProgressCard extends ConsumerWidget {
  final ValueSetter<int> switchTab;
  const ProgressCard(this.switchTab, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final user = ref.watch(userProvider)!;

    final readingGoal = user.pages ?? user.minutes;

    return Card(
      elevation: 5,
      shadowColor: Pallete.textGreyLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                ref.watch(todaysProgressProvider).when(
                    loading: () => const Loader(),
                    error: (error, stackTrace) => Text(error.toString()),
                    data: (data) {
                      int minutes = 0;
                      int pages = 0;
                      for (var log in data) {
                        minutes += log.minutes;
                        pages += log.pages;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.type! == GoalType.pages
                                ? pages.toString()
                                : minutes.toString(),
                            style: const TextStyle(
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
                      );
                    }),
                Center(
                    child: Text(describeGoalTypeEnum(user.type!),
                        style: AppStyles.bodyText)),
                const SizedBox(height: 16),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: CustomButton(
                          text: 'Read Now', onPressed: () => switchTab(2)),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
