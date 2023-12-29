import 'package:clean_firenote/core/usecases/usecases.dart';

import '../repository/auth_repository.dart';

class SignInWithAppleUseCase extends UseCase<void, void> {
  final AuthRepository _authRepository;

  SignInWithAppleUseCase(this._authRepository);

  @override
  Future<void> call({void params}) {
    return _authRepository.signInWithApple();
  }

}