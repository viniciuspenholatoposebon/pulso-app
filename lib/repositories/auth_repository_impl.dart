import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'auth_repository.dart';

/// Implementação padrão de [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  UserModel? get currentUser => _authService.currentUser;

  @override
  Stream<UserModel?> authStateChanges() {
    return _authService.authStateChanges();
  }

  @override
  Future<UserModel> login(
    String email,
    String password,
  ) async {
    try {
      return await _authService.signInWithEmail(
        email,
        password,
      );
    } on AppException catch (e) {
      throw AuthFailure(e.message);
    }
  }

  @override
  Future<UserModel> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      return await _authService.createUserWithEmail(
        name,
        email,
        password,
      );
    } on AppException catch (e) {
      throw AuthFailure(e.message);
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      return await _authService.signInWithGoogle();
    } on AppException catch (e) {
      throw AuthFailure(e.message);
    }
  }

  @override
  Future<void> resetPassword(
    String email,
  ) async {
    try {
      await _authService.sendPasswordResetEmail(email);
    } on AppException catch (e) {
      throw AuthFailure(e.message);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _authService.signOut();
    } on AppException catch (e) {
      throw AuthFailure(e.message);
    }
  }
}
