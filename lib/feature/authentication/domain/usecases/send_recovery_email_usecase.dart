import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class SendRecoveryEmailUseCase implements UseCase<void, String> {
  final AuthRepository _authRepository;

  SendRecoveryEmailUseCase(this._authRepository);

  @override
  Future<void> call({String? params}) {
    return _authRepository.sendRecoveryEmail(params!);
  }
}