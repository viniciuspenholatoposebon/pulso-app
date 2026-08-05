/// Constantes globais do app PULSO.
class AppConstants {
  AppConstants._();

  static const String appName = 'PULSO';

  /// Base da API própria. Substituir pela URL real quando o backend
  /// estiver disponível.
  static const String apiBaseUrl = 'https://api.pulso.app';

  static const Duration networkTimeout = Duration(seconds: 15);

  /// Identificadores dos planos de assinatura Plus (Google Play Billing).
  static const String planPlusMonthly = 'pulso_plus_monthly';
  static const String planPlusAnnual = 'pulso_plus_annual';
}
