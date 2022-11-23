import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/features/auth/repository/auth_repository.dart';
import 'package:reading_tracker/models/user_model.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); // <--- false is the initial state of loading variable

  Stream<User?> get authStateChange => _authRepository.authStateChanges;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signinWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signinWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signUp(
      String name, String email, String password, BuildContext context) async {
    state = true;
    final user = await _authRepository.signUp(name, email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void singIn(String email, String password, BuildContext context) async {
    state = true;
    final user = await _authRepository.signIn(email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void logout() async {
    _authRepository.logout();
  }
}
