import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/auth/auth_event.dart';
import 'package:payment_app/blocs/auth/auth_state.dart';
import 'package:payment_app/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SingInEvent>(_singIn);
    on<SingUpEvent>(_singUp);
    on<SingOut>(_singOut);
  }

  void _singIn(SingInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.singIn(
        email: event.email,
        password: event.password,
      );
      if (result == null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(message: result));
      }
    } catch (e) {
      emit(AuthError(message: "Xatolik: $e"));
    }
  }

  void _singUp(SingUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.singUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      if (result == null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(message: result));
      }
    } catch (e) {
      emit(AuthError(message: "Xatolik: $e"));
    }
  }

  void _singOut(SingOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.singOut();
      emit(AuthUnAuthenticated());
    } catch (e) {
      emit(AuthError(message: "Xatolik: $e"));
    }
  }
}
