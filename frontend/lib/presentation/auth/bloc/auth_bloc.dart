import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/auth/usecases/auth_usecase.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase useCase;

  AuthBloc(this.useCase) : super(AuthState.initial()) {
    on<AuthCheckRequested>((event, emit) async {
      final prefs = await SharedPreferencesService.getInstance();
      final Map<String, dynamic>? savedData = prefs.getData('auth');

      if (savedData != null) {
        final statusString = savedData['status'] as String;
        final userMap = savedData['user'] as Map<String, dynamic>?;
        final userObj = userMap != null ? AuthUser.fromJson(userMap) : null;

        AuthStatus status = statusString == 'authenticated'
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;

        emit(AuthState(status: status, user: userObj));
      } else {
        emit(AuthState.initial());
      }
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      await Future.delayed(const Duration(seconds: 4));

      try {
        await useCase.logar(event.cpf, event.senha);
        emit(state.copyWith(status: AuthStatus.authenticated));
      } catch (e) {
        emit(state.copyWith(status: AuthStatus.error));
        return;
      }
      emit(state.copyWith(status: AuthStatus.authenticated));
    });

    on<AuthLogoutRequested>((event, emit) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    });
  }
}
