/// Contrato do serviço de notificações push.
/// Quando `firebase_messaging` for adicionado ao projeto, criar
/// `FirebaseNotificationService` implementando esta interface e trocar
/// o provider correspondente — nenhuma outra camada precisa mudar.
abstract class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<String?> getDeviceToken();
}

/// Implementação simulada, sem FCM conectado.
class MockNotificationService implements NotificationService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<String?> getDeviceToken() async => null;
}
