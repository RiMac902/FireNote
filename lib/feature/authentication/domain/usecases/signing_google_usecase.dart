import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<void, void> {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  @override
  Future<void> call({void params}) {
    return _authRepository.signInWithGoogle();
  }
}