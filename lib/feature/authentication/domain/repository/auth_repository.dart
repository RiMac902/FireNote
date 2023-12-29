import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  bool isLoggedIn();

  User? getCurrentUser();

  Future<void> sendRecoveryEmail(String email);

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<void> signInWithApple();

  Future<void> changeDisplayName(String displayName);

  Future<void> changePassword(String password);

  Future<void> changeEmail(String email);

  Future<void> sendVerifyEmail();

  Future<void> saveProfilePhoto(File photo);
}