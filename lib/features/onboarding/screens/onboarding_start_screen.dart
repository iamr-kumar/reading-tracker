import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    void startOnboarding() {
      Routemaster.of(context).push('/onboarding/select-book');
    }

    Widget onboardingIllustration = SvgPicture.asset(
        Constants.onboardingFirstIllustration,
        height: devHeight * 0.6);

    return Scaffold(
      // backgroundColor: Pallete.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onboardingIllustration,
              SizedBox(height: devHeight * 0.03),
              const Text(
                'Hey, there!',
                style: AppStyles.headingThree,
              ),
              const SizedBox(height: 8),
              const Text(
                'We just need to get some things ready to get you started',
                style: AppStyles.subtext,
              ),
              SizedBox(
                height: devHeight * 0.06,
              ),
              CustomButton(
                text: 'Begin',
                onPressed: startOnboarding,
                // isOutlined: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
