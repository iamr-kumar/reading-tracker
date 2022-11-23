import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reading_tracker/core/constants/firebase_constants.dart';
import 'package:reading_tracker/core/failure.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/models/user_model.dart';
import 'package:reading_tracker/providers/firebase_providers.dart';

// using ref.read instead of ref.watch because ref.read is generally used outside of the
// build context. Anyway these providers are of type Provider which ensures immutability
// so using read or watch would not make a difference but ref.read is recommended.
// Provider allows to talk to other providers.
final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSigninProvider)));

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  FutureEither<UserModel> signUp(
      String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return left(Failure('Some error occurred'));
      }
      final userModel = UserModel(
        uid: user.uid,
        name: name,
        email: email,
        onboardingComplete: false,
      );
      await _users.doc(user.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-already-exists') {
        throw Failure('User already exists');
      }
      throw e.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<UserModel> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return left(Failure('Some error occurred'));
      }
      final userModel = await getUserData(user.uid).first;
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Failure('Invalid email or password');
      } else if (e.code == 'wrong-password') {
        throw Failure('Invalid email or password');
      }
      throw e.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<UserModel> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'Untitled',
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          photoURL: userCredential.user!.photoURL ?? '',
          onboardingComplete: false,
        );

        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>));
  }

  void logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
