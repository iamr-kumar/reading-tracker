import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/error_text.dart';
import 'package:reading_tracker/core/widgets/loader.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';
import 'package:reading_tracker/firebase_options.dart';
import 'package:reading_tracker/models/user_model.dart';
import 'package:reading_tracker/router.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Read Wise',
              theme: ThemeData(
                fontFamily: 'Poppins',
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
              ),
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    if (userModel!.readingBook != null) {
                      return authenticatedRoutes;
                    } else {
                      return onboardingRoutes;
                    }
                  }
                }
                return guestRoutes;
              }),
              routeInformationParser: const RoutemasterParser(),
              // home: const WelcomeScreen(),
            ),
        error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
        loading: () => const Loader());
  }
}
