
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/usecases/usecases.dart';
import '../repository/auth_repository.dart';

class GetCurrentUserUseCase implements SyncUseCase<User?, void> {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  @override
  User? call({void params}) {
    return _authRepository.getCurrentUser();
  }
}