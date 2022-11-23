import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Onboarding Screen'),
            CustomButton(text: 'Logout', onPressed: () => logout(ref))
          ],
        ),
      ),
    );
  }
}
