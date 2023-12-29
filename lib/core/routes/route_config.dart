import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/authentication/domain/repository/auth_repository.dart';
import '../../feature/authentication/presentation/register/screens/create_account_screen.dart';
import '../../feature/authentication/presentation/register/screens/forgot_password_screen.dart';
import '../../feature/authentication/presentation/register/screens/login_screen.dart';
import '../../feature/notes/presentation/home/home_screen.dart';
import '../../injection_container.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      }
    ),
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        }
    ),
    GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateAccountScreen();
        }
    ),
    GoRoute(
        path: '/forgotPassword',
        name: 'forgotPassword',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordScreen();
        }
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthenticated = sl<AuthRepository>().isLoggedIn();

    if (state.fullPath == '/login') {
      return isAuthenticated ? '/' : '/login';
    }

    return null;
  }
);


