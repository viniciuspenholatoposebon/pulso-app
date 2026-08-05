/// Exceção base lançada pela camada de serviços (data layer).
class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Lançada por falhas de autenticação (credenciais inválidas, etc.).
class AuthException extends AppException {
  const AuthException(super.message);
}

/// Lançada por falhas de rede/conectividade.
class NetworkException extends AppException {
  const NetworkException(super.message);
}
