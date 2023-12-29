import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:clean_firenote/feature/authentication/data/data_sources/firebase_auth_service.dart';
import 'package:clean_firenote/feature/authentication/data/data_sources/firebase_storage_service.dart';
import 'package:clean_firenote/feature/authentication/domain/repository/auth_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return _authService.signInWithCredentials(oauthCredential);
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
