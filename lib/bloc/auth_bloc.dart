import 'package:muud_health/bloc/auth_event.dart';
import 'package:muud_health/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_api.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<AuthLoggedOut>((event, emit) => emit(AuthInitial()));

  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await AuthApi.login(event.username, event.password);
      if (result['success'] == true && result['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result['token']);
       await prefs.setString('userId', result['userId'].toString());

        emit(AuthSuccess(result['token'], result['userId'].toString()));
      } else {
        emit(AuthFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
