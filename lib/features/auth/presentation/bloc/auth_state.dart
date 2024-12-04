class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

abstract class AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess({required this.message});
}
