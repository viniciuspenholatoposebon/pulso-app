import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../../../providers/repository_providers.dart';
import '../../../../repositories/auth_repository.dart';

/// Estado imutável da tela de login.
class LoginState {
  final bool rememberMe;
  final bool isSubmitting;
  final String? errorMessage;

  const LoginState({
    this.rememberMe = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? rememberMe,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

/// Controller da tela de login.
class LoginController extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState());

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(isSubmitting: true, clearError: true);

    try {
      await _authRepository.login(email, password);

      state = state.copyWith(isSubmitting: false);
      return true;
    } on Failure catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.message,
      );
      return false;
    }
  }

  Future<bool> submitWithGoogle() async {
    state = state.copyWith(isSubmitting: true, clearError: true);

    try {
      await _authRepository.loginWithGoogle();

      state = state.copyWith(isSubmitting: false);
      return true;
    } on Failure catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.message,
      );
      return false;
    }
  }

  /// Apple ainda não foi implementado.
  /// Mantemos o método para não quebrar a UI.
  Future<bool> submitWithApple() async {
    state = state.copyWith(
      errorMessage: 'Login com Apple será disponibilizado na versão iOS.',
    );

    return false;
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
  return LoginController(
    ref.watch(authRepositoryProvider),
  );
});
