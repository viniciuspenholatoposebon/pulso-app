/// Validadores de campos de formulário reutilizáveis entre telas.
class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r'^[\w.\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe seu e-mail';
    if (!_emailRegex.hasMatch(value.trim())) return 'E-mail inválido';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Informe sua senha';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }
}
