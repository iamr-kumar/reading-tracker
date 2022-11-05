import 'package:flutter/material.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:routemaster/routemaster.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;

    void showSignupScreen() {
      Routemaster.of(context).push('/signup');
    }

    void showLoginScreen() {
      Routemaster.of(context).push('/login');
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: devHeight * 0.58,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/welcome.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: devHeight * 0.02,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                'Never miss a Reading Day',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Pallete.textBlue),
              ),
            ),
            SizedBox(
              height: devHeight * 0.02,
            ),
            const SizedBox(
                width: 350,
                child: Text(
                  'Set your reading goals. Get Reminders. Track your progress. Read more.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Pallete.textGrey),
                )),
            SizedBox(height: devHeight * 0.08),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 7.5),
                            child: CustomButton(
                              text: 'Signup',
                              onPressed: showSignupScreen,
                            ))),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.5),
                        child: Expanded(
                            child: CustomButton(
                          text: 'Login',
                          isOutlined: true,
                          onPressed: showLoginScreen,
                        )),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
