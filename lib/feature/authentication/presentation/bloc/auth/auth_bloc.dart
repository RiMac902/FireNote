import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/edit_user_usecase.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';
import '../../../domain/usecases/send_recovery_email_usecase.dart';
import '../../../domain/usecases/signin_apple_usecase.dart';
import '../../../domain/usecases/signin_email_password.dart';
import '../../../domain/usecases/signin_facebook_usecase.dart';
import '../../../domain/usecases/signing_google_usecase.dart';
import '../../../domain/usecases/signout.dart';
import '../../../domain/usecases/signup_email_password.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SendRecoveryEmailUseCase _sendRecoveryEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final ChangeDisplayNameUseCase _changeDisplayNameUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  AuthBloc(
    this._signInWithEmailAndPasswordUseCase,
    this._signUpWithEmailAndPasswordUseCase,
    this._signOutUseCase,
    this._getCurrentUserUseCase,
    this._sendRecoveryEmailUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithFacebookUseCase,
    this._changeDisplayNameUseCase,
    this._signInWithAppleUseCase,
  ) : super(const AuthSuccess()) {
    on<SignInEmailPasswordAuthEvent>(_onSignInEmailPassword);
    on<SignUpEmailPasswordAuthEvent>(_onSignUpEmailPassword);
    on<SignOutAuthEvent>(_onSignOut);
    on<SendRecoveryEmailAuthEvent>(_onSendRecoveryEmail);
    on<SignInWithGoogleAuthEvent>(_onSignInWithGoogle);
    on<SignInWithFacebookAuthEvent>(_onSignInWithFacebook);
  }

  _onSignInEmailPassword(
      SignInEmailPasswordAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signInWithEmailAndPasswordUseCase(params: {
        'email': event.email,
        'password': event.password,
      });
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('home');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSignInWithGoogle(
      SignInWithGoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signInWithGoogleUseCase();
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('home');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSignInWithFacebook(
      SignInWithFacebookAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signInWithFacebookUseCase();
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('home');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSignInWithApple(SignInWithAppleAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signInWithAppleUseCase();
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('home');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSignUpEmailPassword(
      SignUpEmailPasswordAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signUpWithEmailAndPasswordUseCase(params: {
        'email': event.email,
        'password': event.password,
      });
      await _changeDisplayNameUseCase(params: event.displayName);
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('home');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSignOut(SignOutAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _signOutUseCase();
      emit(const AuthSuccess());
      GoRouter.of(event.context).goNamed('login');
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _onSendRecoveryEmail(
      SendRecoveryEmailAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _sendRecoveryEmailUseCase(
        params: event.email,
      );
      emit(const AuthSuccess());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(const SnackBar(content: Text('Recovery email sent!')));
    } catch (e) {
      emit(const AuthFailure());
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  User? getCurrentUser() {
    return _getCurrentUserUseCase();
  }
}
