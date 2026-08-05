import '../models/subscription_model.dart';

/// Contrato do serviço de assinatura Plus.
/// Quando `in_app_purchase` for adicionado, criar
/// `PlayBillingSubscriptionService` implementando esta interface e trocar
/// o provider correspondente — nenhuma outra camada precisa mudar.
abstract class SubscriptionService {
  Future<SubscriptionModel> getCurrentSubscription(String userId);
  Future<SubscriptionModel> purchasePlan(String planId);
  Future<void> restorePurchases();
}

/// Implementação simulada, sem Google Play Billing conectado.
class MockSubscriptionService implements SubscriptionService {
  @override
  Future<SubscriptionModel> getCurrentSubscription(String userId) async {
    return SubscriptionModel.none();
  }

  @override
  Future<SubscriptionModel> purchasePlan(String planId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return SubscriptionModel(
      planId: planId,
      status: SubscriptionStatus.active,
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );
  }

  @override
  Future<void> restorePurchases() async {}
}
