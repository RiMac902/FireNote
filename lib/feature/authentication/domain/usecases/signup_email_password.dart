import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class SignUpWithEmailAndPasswordUseCase implements UseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  SignUpWithEmailAndPasswordUseCase(this._authRepository);

  @override
  Future<void> call({Map<String, dynamic>? params}) {
    return _authRepository.createUserWithEmailAndPassword(params!['email'], params['password']);
  }
}