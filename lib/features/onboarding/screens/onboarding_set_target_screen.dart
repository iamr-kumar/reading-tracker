import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/onboarding/controllers/onboarding_controller.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:reading_tracker/utils/show_dialog.dart';
import 'package:routemaster/routemaster.dart';

class OnboardingSetTargetScreen extends ConsumerStatefulWidget {
  const OnboardingSetTargetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingSetTargetScreenState();
}

class _OnboardingSetTargetScreenState
    extends ConsumerState<OnboardingSetTargetScreen> {
  int? pages;
  int? minutes;

  TextEditingController _targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    final Widget onboardingSetTargetIllustration = SvgPicture.asset(
        Constants.onboardingSetTargetIllustration,
        height: devHeight * 0.6);

    final selectedBook = ref.watch(bookControllerProvider).selectedBook;

    final pages = ref.watch(onboardingControllerProvider).pages;

    final minutes = ref.watch(onboardingControllerProvider).minutes;

    void routeBack() {
      Routemaster.of(context).pop();
    }

    void updateTarget(String text) {
      ref.read(onboardingControllerProvider.notifier).setPages(int.parse(text));
    }

    String getSubtext() {
      if (pages != null) {
        return 'You have set your goal to read $pages pages per day';
      } else if (minutes != null) {
        return 'You have set your goal to read $minutes minutes per day';
      } else {
        return 'Tell us about your daily reading goals either in pages or minutes';
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8, bottom: 16.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: routeBack,
              child: const Icon(
                FeatherIcons.chevronLeft,
                color: Pallete.primaryBlue,
              ),
            ),
            onboardingSetTargetIllustration,
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Set your goal',
              style: AppStyles.headingTwo,
            ),
            Text(
              getSubtext(),
              style: AppStyles.subtext,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          text: 'Set Goal',
                          onPressed: () async {
                            await showSetTargetDialog(
                                context, _targetController);
                            if (_targetController.text.isNotEmpty) {
                              updateTarget(_targetController.text);
                            }
                          }),
                    ),
                    Visibility(
                      visible: pages != null || minutes != null,
                      child: const SizedBox(
                        width: 16,
                      ),
                    ),
                    Visibility(
                      visible: pages != null || minutes != null,
                      child: InkWell(
                        onTap: () {
                          Routemaster.of(context)
                              .push('/onboarding/select-time');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Pallete.primaryBlue),
                          child: const Icon(
                            FeatherIcons.arrowRight,
                            color: Pallete.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
