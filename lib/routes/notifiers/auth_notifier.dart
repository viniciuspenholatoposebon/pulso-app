import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../repositories/auth_repository.dart';

/// Notifica o GoRouter sempre que o estado de autenticação mudar.
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._authRepository) {
    _subscription = _authRepository.authStateChanges().listen((_) {
      notifyListeners();
    });
  }

  final AuthRepository _authRepository;

  late final StreamSubscription _subscription;

  bool get isLoggedIn => _authRepository.currentUser != null;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
