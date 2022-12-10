import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/onboarding/controllers/onboarding_controller.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class OnboardingFinishScreen extends ConsumerWidget {
  const OnboardingFinishScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devHeight = MediaQuery.of(context).size.height;

    void routeBack() {
      Routemaster.of(context).pop();
    }

    final selectedBook = ref.watch(bookControllerProvider).selectedBook;

    final data = ref.watch(onboardingControllerProvider);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8, bottom: 16.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: devHeight * 0.02,
            ),
            InkWell(
              onTap: routeBack,
              child: const Icon(
                FeatherIcons.chevronLeft,
                color: Pallete.primaryBlue,
              ),
            ),
            SizedBox(
              height: devHeight * 0.01,
            ),
            const Text('Let\'s finish up', style: AppStyles.headingTwo),
            SizedBox(
              height: devHeight * 0.02,
            ),
            Text('You\'re set to read',
                style: AppStyles.bodyText.copyWith(color: Pallete.textGrey)),
            SizedBox(
              height: devHeight * 0.02,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(selectedBook!.thumbnail!),
                  ),
                  SizedBox(
                    height: devHeight * 0.01,
                  ),
                  Text(selectedBook.title,
                      style: AppStyles.subtext.copyWith(
                          color: Pallete.primaryBlue,
                          fontWeight: FontWeight.w500)),
                  Text('by ${selectedBook.authors.join(', ')}',
                      style: AppStyles.bodyText),
                ],
              ),
            ),
            SizedBox(
              height: devHeight * 0.02,
            ),
            const Text('Your target is', style: AppStyles.bodyText),
            SizedBox(
              height: devHeight * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${data.pages} pages',
                      style: AppStyles.subheading.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Pallete.primaryBlue)),
                  const Text('per day', style: AppStyles.bodyText),
                ],
              ),
            ),
            SizedBox(
              height: devHeight * 0.02,
            ),
            const Text('You\'ll be notified at', style: AppStyles.bodyText),
            SizedBox(
              height: devHeight * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data.time!.format(context),
                      style: AppStyles.subheading.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Pallete.primaryBlue)),
                  const Text('every day', style: AppStyles.bodyText),
                ],
              ),
            ),
            SizedBox(
              height: devHeight * 0.06,
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(text: 'Finish', onPressed: () {})))
          ],
        ),
      ),
    ));
  }
}
