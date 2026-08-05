import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pulso_app/app.dart';

void main() {
  testWidgets('Pulso inicia corretamente', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PulsoApp(),
      ),
    );

    expect(find.byType(PulsoApp), findsOneWidget);
  });
}