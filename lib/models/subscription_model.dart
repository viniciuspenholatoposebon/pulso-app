/// Status de uma assinatura Plus.
enum SubscriptionStatus { active, expired, canceled, none }

/// Modelo de assinatura do plano Plus.
/// Preparado para integração com Google Play Billing (in_app_purchase).
class SubscriptionModel {
  final String planId;
  final SubscriptionStatus status;
  final DateTime? expiresAt;

  const SubscriptionModel({
    required this.planId,
    required this.status,
    this.expiresAt,
  });

  factory SubscriptionModel.none() => const SubscriptionModel(
        planId: '',
        status: SubscriptionStatus.none,
      );

  bool get isActive => status == SubscriptionStatus.active;
}
