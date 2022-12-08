import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/books/controllers/book_controller.dart';
import 'package:reading_tracker/features/books/screens/book_search.dart';
import 'package:reading_tracker/models/book_model.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class OnboardingBookSelectScreen extends ConsumerWidget {
  const OnboardingBookSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devHeight = MediaQuery.of(context).size.height;

    final Widget onboardingBookSearchIllustration = SvgPicture.asset(
        Constants.onboardingBookSearchIllustration,
        height: devHeight * 0.55);

    Book? selectedBook = ref.watch(bookControllerProvider).selectedBook;

    void routeBack() {
      Routemaster.of(context).pop();
    }

    void searchBook(BuildContext context) {
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          isDismissible: false,
          isScrollControlled: true,
          builder: (ctx) {
            return SizedBox(
              height: devHeight * 0.95,
              child: const BookSearch(),
            );
          });
    }

    void nextPage() {
      Routemaster.of(context).push('/onboarding/select-progress');
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            onboardingBookSearchIllustration,
            const Text(
              'Add a book',
              style: AppStyles.headingTwo,
            ),
            selectedBook == null
                ? const Text(
                    'Search for a book that you are currently reading or planning to read',
                    style: AppStyles.subtext,
                  )
                : Text(
                    'You are currently set for a wonderful journey ahead with ${selectedBook.title}',
                    style: AppStyles.subtext,
                  ),
            SizedBox(
              height: devHeight * 0.06,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      text: 'Find Book', onPressed: () => searchBook(context)),
                ),
                Visibility(
                  visible: selectedBook != null,
                  child: const SizedBox(
                    width: 16,
                  ),
                ),
                Visibility(
                  visible: selectedBook != null,
                  child: InkWell(
                    onTap: nextPage,
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
            )
          ],
        ),
      ),
    ));
  }
}
