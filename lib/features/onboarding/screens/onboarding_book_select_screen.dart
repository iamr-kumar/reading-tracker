import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/books/screens/book_search.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class OnboardingBookSelectScreen extends StatelessWidget {
  const OnboardingBookSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    final Widget onboardingBookSearchIllustration = SvgPicture.asset(
        Constants.onboardingBookSearchIllustration,
        height: devHeight * 0.55);

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
              child: const CircleAvatar(
                backgroundColor: Pallete.primaryBlue,
                child: Icon(FeatherIcons.chevronLeft),
              ),
            ),
            onboardingBookSearchIllustration,
            const Text(
              'Add a book',
              style: AppStyles.headingTwo,
            ),
            const Text(
              'Search for a book that you are currently reading or planning to read',
              style: AppStyles.subtext,
            ),
            SizedBox(
              height: devHeight * 0.06,
            ),
            CustomButton(
                text: 'Find Book', onPressed: () => searchBook(context))
          ],
        ),
      ),
    ));
  }
}
