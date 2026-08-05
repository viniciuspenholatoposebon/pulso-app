import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service.dart';
import '../services/firebase_auth_service.dart';
import '../services/notification_service.dart';
import '../services/subscription_service.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) => FirebaseAuthService(),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => MockNotificationService(),
);

final subscriptionServiceProvider = Provider<SubscriptionService>(
  (ref) => MockSubscriptionService(),
);
