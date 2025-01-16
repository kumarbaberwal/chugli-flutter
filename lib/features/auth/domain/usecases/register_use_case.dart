import 'package:vibematch/features/auth/domain/entities/user_entity.dart';
import 'package:vibematch/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});
  Future<UserEntity> call(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}
