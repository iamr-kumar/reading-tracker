import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reading_tracker/core/constants/local_constants.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    void showLoginScreen() {
      Routemaster.of(context).push('/login');
    }

    final Widget welcomeIllustration = SvgPicture.asset(
        Constants.welcomeIllustration,
        height: devHeight * 0.6);

    return Scaffold(
      backgroundColor: Pallete.primaryBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            welcomeIllustration,
            SizedBox(height: devHeight * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(Constants.appName,
                      textAlign: TextAlign.left,
                      style:
                          AppStyles.headingOne.copyWith(color: Pallete.white)),
                ),
                SizedBox(
                  height: devHeight * 0.02,
                ),
                Text(Constants.welcomeMessage,
                    textAlign: TextAlign.left,
                    style: AppStyles.subtext
                        .copyWith(color: Pallete.textGreyLight)),
                SizedBox(height: devHeight * 0.04),
                CustomButton(
                  text: 'Get Started',
                  onPressed: showLoginScreen,
                  isOutlined: true,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
