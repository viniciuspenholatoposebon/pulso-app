/// Falha genérica exposta pelos repositórios à camada de apresentação
/// (controllers/providers). Mantém a UI desacoplada das exceções de baixo
/// nível lançadas pelos serviços.
class Failure {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
