import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devHeight = MediaQuery.of(context).size.height;

    Widget onboardingIllustration = SvgPicture.asset(
        Constants.onboardingFirstIllustration,
        height: devHeight * 0.65);

    return Scaffold(
      backgroundColor: Pallete.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onboardingIllustration,
              SizedBox(height: devHeight * 0.03),
              Text(
                'Let\'s get some things ready for you!',
                style: AppStyles.headingTwo.copyWith(color: Pallete.white),
              ),
              SizedBox(
                height: devHeight * 0.04,
              ),
              CustomButton(
                text: 'Begin',
                onPressed: () => logout(ref),
                isOutlined: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
