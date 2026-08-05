import '../models/user_model.dart';

/// Contrato do repositório de autenticação.
abstract class AuthRepository {
  /// Usuário atualmente autenticado.
  UserModel? get currentUser;

  /// Escuta mudanças na autenticação.
  Stream<UserModel?> authStateChanges();

  /// Login com e-mail e senha.
  Future<UserModel> login(
    String email,
    String password,
  );

  /// Cadastro com e-mail e senha.
  Future<UserModel> register(
    String name,
    String email,
    String password,
  );

  /// Login com Google.
  Future<UserModel> loginWithGoogle();

  /// Recuperação de senha.
  Future<void> resetPassword(
    String email,
  );

  /// Logout.
  Future<void> logout();
}
