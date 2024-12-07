import 'package:chugli/features/auth/domain/usecases/login_use_case.dart';
import 'package:chugli/features/auth/domain/usecases/register_use_case.dart';
import 'package:chugli/features/auth/presentation/bloc/auth_event.dart';
import 'package:chugli/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      emit(AuthFailure(error: "Registration failed"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user =
          await registerUseCase(event.username, event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      emit(AuthFailure(error: "Registration failed"));
    }
  }
}
