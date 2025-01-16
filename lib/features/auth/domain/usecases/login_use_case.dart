import 'package:vibematch/features/auth/domain/entities/user_entity.dart';
import 'package:vibematch/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
