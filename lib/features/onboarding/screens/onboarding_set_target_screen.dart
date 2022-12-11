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
  int? type = 1;

  TextEditingController _targetController = TextEditingController();

  void setTargetType(int? value) {
    ref.read(onboardingControllerProvider.notifier).setType(value);
  }

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    final Widget onboardingSetTargetIllustration = SvgPicture.asset(
        Constants.onboardingSetTargetIllustration,
        height: devHeight * 0.6);

    final pages = ref.watch(onboardingControllerProvider).pages;

    final minutes = ref.watch(onboardingControllerProvider).minutes;

    void routeBack() {
      Routemaster.of(context).pop();
    }

    void updateTarget(String text) {
      if (type == 1) {
        ref
            .read(onboardingControllerProvider.notifier)
            .setPages(int.parse(text));
      } else {
        ref
            .read(onboardingControllerProvider.notifier)
            .setMinutes(int.parse(text));
      }
      ref.read(onboardingControllerProvider.notifier).setType(type);
    }

    void updateType(int? value) {
      setState(() {
        type = value;
      });
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
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    // contentPadding: const EdgeInsets.all(0),
                                    insetPadding: const EdgeInsets.all(16),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 16),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile(
                                                  title: const Text('Pages'),
                                                  value: 1,
                                                  groupValue: type,
                                                  onChanged: (value) =>
                                                      updateType(value)),
                                            ),
                                            Expanded(
                                              child: RadioListTile(
                                                  title: const Text('Minutes'),
                                                  value: 2,
                                                  groupValue: type,
                                                  onChanged: (value) =>
                                                      updateType(value)),
                                            )
                                          ],
                                        ),
                                        TextFormField(
                                          controller: _targetController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: "Enter your goal"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });

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
