// Guest Routes
import 'package:flutter/material.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/features/auth/screens/login_screen.dart';
import 'package:reading_tracker/features/auth/screens/singup_screen.dart';
import 'package:reading_tracker/features/auth/screens/welcome_screen.dart';
import 'package:reading_tracker/features/onboarding/screens/onboarding_screen.dart';
import 'package:routemaster/routemaster.dart';

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
  // '/create-community': (_) =>
  //     const MaterialPage(child: CreateCommunityScreen()),
  // '/r/:name': (route) =>
  //     MaterialPage(child: CommunityScreen(name: route.pathParameters['name']!)),
  // '/mod-tools/:name': (route) =>
  //     MaterialPage(child: ModToolsScreen(name: route.pathParameters['name']!)),
  // '/edit-community/:name': (route) => MaterialPage(
  //     child: EditCommunityScreen(name: route.pathParameters['name']!))
});
