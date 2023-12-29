import 'package:clean_firenote/feature/authentication/domain/usecases/signin_apple_usecase.dart';
import 'package:get_it/get_it.dart';

import 'feature/authentication/data/data_sources/firebase_auth_service.dart';
import 'feature/authentication/data/data_sources/firebase_storage_service.dart';
import 'feature/authentication/data/repository/auth_repository_impl.dart';
import 'feature/authentication/domain/repository/auth_repository.dart';
import 'feature/authentication/domain/usecases/edit_user_usecase.dart';
import 'feature/authentication/domain/usecases/get_current_user_usecase.dart';
import 'feature/authentication/domain/usecases/send_recovery_email_usecase.dart';
import 'feature/authentication/domain/usecases/signin_email_password.dart';
import 'feature/authentication/domain/usecases/signin_facebook_usecase.dart';
import 'feature/authentication/domain/usecases/signing_google_usecase.dart';
import 'feature/authentication/domain/usecases/signout.dart';
import 'feature/authentication/domain/usecases/signup_email_password.dart';
import 'feature/authentication/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /// Auth:
  sl.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  sl.registerSingleton<FirebaseStorageService>(FirebaseStorageService());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  ///UseCases

  ///Auth:
  sl.registerSingleton<SignInWithEmailAndPasswordUseCase>(SignInWithEmailAndPasswordUseCase(sl()));
  sl.registerSingleton<SignUpWithEmailAndPasswordUseCase>(SignUpWithEmailAndPasswordUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<GetCurrentUserUseCase>(GetCurrentUserUseCase(sl()));
  sl.registerSingleton<SendRecoveryEmailUseCase>(SendRecoveryEmailUseCase(sl()));
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase(sl()));
  sl.registerSingleton<SignInWithFacebookUseCase>(SignInWithFacebookUseCase(sl()));
  sl.registerSingleton<SignInWithAppleUseCase>(SignInWithAppleUseCase(sl()));
  sl.registerSingleton<ChangeDisplayNameUseCase>(ChangeDisplayNameUseCase(sl()));
  sl.registerSingleton<ChangeEmailUseCase>(ChangeEmailUseCase(sl()));
  sl.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(sl()));
  sl.registerSingleton<SendVerifyEmailUseCase>(SendVerifyEmailUseCase(sl()));
  sl.registerSingleton<ChangeProfilePhotoUseCase>(ChangeProfilePhotoUseCase(sl()));

  ///Blocs

  ///Global:
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));


}