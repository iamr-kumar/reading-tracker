// Guest Routes
import 'package:flutter/material.dart';
import 'package:reading_tracker/features/auth/screens/login_screen.dart';
import 'package:reading_tracker/features/auth/screens/singup_screen.dart';
import 'package:reading_tracker/features/auth/screens/welcome_screen.dart';
import 'package:reading_tracker/features/onboarding/screens/onboarding_book_select_screen.dart';
import 'package:reading_tracker/features/onboarding/screens/onboarding_start_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/onboarding/screens/onboarding_set_target_screen.dart';

final guestRoutes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: WelcomeScreen()),
  '/login': (_) => const MaterialPage(child: LoginScreen()),
  '/signup': (_) => const MaterialPage(child: SignupScreen()),
});

// Authenticated Routes
final authenticatedRoutes =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  '/': (_) => const MaterialPage(child: OnboardingScreen()),
  '/signup': (_) => const Redirect('/'),
  '/login': (_) => const Redirect('/'),
});

final onboardingRoutes =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  '/': (_) => const MaterialPage(child: OnboardingScreen()),
  '/onboarding/select-book': (_) =>
      const MaterialPage(child: OnboardingBookSelectScreen()),
  '/onboarding/set-target': (_) =>
      const MaterialPage(child: OnboardingSetTargetScreen())
});
