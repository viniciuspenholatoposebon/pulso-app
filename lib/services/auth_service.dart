import '../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Contrato responsável pela autenticação.
///
/// A implementação pode ser:
/// - MockAuthService (desenvolvimento)
/// - FirebaseAuthService (produção)
abstract class AuthService {
  /// Usuário atualmente autenticado.
  UserModel? get currentUser;

  /// Escuta mudanças de autenticação.
  Stream<UserModel?> authStateChanges();

  /// Login com e-mail e senha.
  Future<UserModel> signInWithEmail(
    String email,
    String password,
  );

  /// Cadastro com e-mail e senha.
  Future<UserModel> createUserWithEmail(
    String name,
    String email,
    String password,
  );

  /// Login Google.
  Future<UserModel> signInWithGoogle();

  /// Recuperação de senha.
  Future<void> sendPasswordResetEmail(
    String email,
  );

  /// Logout.
  Future<void> signOut();
}

/// ---------------------------------------------------------------------------
///
/// IMPLEMENTAÇÃO MOCK
///
/// ---------------------------------------------------------------------------

class MockAuthService implements AuthService {
  UserModel? _currentUser;

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Stream<UserModel?> authStateChanges() async* {
    yield _currentUser;
  }

  @override
  Future<UserModel> signInWithEmail(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (password.length < 6) {
      throw const AuthException('Credenciais inválidas');
    }

    _currentUser = UserModel(
      id: 'mock-user-id',
      name: 'Aluno PULSO',
      email: email,
      emailVerified: true,
    );

    return _currentUser!;
  }

  @override
  Future<UserModel> createUserWithEmail(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 900));

    _currentUser = UserModel(
      id: 'mock-created-user',
      name: name,
      email: email,
    );

    return _currentUser!;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 900));

    _currentUser = const UserModel(
      id: 'mock-google-id',
      name: 'Aluno PULSO',
      email: 'aluno@gmail.com',
      emailVerified: true,
    );

    return _currentUser!;
  }

  @override
  Future<void> sendPasswordResetEmail(
    String email,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
