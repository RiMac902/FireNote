import 'dart:io';

import 'package:clean_firenote/feature/authentication/data/data_sources/firebase_auth_service.dart';
import 'package:clean_firenote/feature/authentication/data/data_sources/firebase_storage_service.dart';
import 'package:clean_firenote/feature/authentication/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;
  final FirebaseStorageService _storageService;

  AuthRepositoryImpl(this._authService, this._storageService);

  @override
  Future<void> changeDisplayName(String displayName) {
    return _authService.changeDisplayName(displayName);
  }

  @override
  Future<void> changeEmail(String email) {
    return _authService.changeEmail(email);
  }

  @override
  Future<void> changePassword(String password) {
    return _authService.changePassword(password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _authService.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  User? getCurrentUser() {
    return _authService.currentUser;
  }

  @override
  bool isLoggedIn() {
    return _authService.currentUser != null;
  }

  @override
  Future<void> saveProfilePhoto(File photo) async {
    final downloadUrl = await _storageService.uploadProfilePhoto(photo, _authService.currentUser!);
    await _authService.changeProfilePhoto(downloadUrl);
  }

  @override
  Future<void> sendRecoveryEmail(String email) {
    return _authService.sendRecoveryEmail(email: email);
  }

  @override
  Future<void> sendVerifyEmail() {
    return _authService.sendVerificationEmail();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );

    await _authService.signInWithCredentials(facebookAuthCredential);
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _authService.signInWithCredentials(credential);
  }
}
