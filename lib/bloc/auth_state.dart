sealed class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String token;
  final String userId; 
  AuthSuccess(this.token,this.userId);
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}