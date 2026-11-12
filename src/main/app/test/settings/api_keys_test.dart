import 'dart:convert';

import 'package:app/settings/views/tabs/api_keys.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:snaptest/snaptest.dart';

import '../helper_widget/test_app_setup_widget.dart';
import '../test_utils.dart';

// built from local dates so the rendered dates don't depend on the machine timezone
int _date(int year, int month, int day, [int hour = 0, int minute = 0]) =>
    DateTime(year, month, day, hour, minute).millisecondsSinceEpoch;

final _apiKeys = jsonEncode([
  {
    'id': 'key-1',
    'name': 'Home server',
    'timeCreated': _date(2025, 10, 9),
    'expiresAt': null,
    'lastUsed': _date(2025, 10, 21, 14, 30),
    'expired': false,
  },
  {
    'id': 'key-2',
    'name': 'Old script',
    'timeCreated': _date(2025, 6, 15),
    'expiresAt': _date(2025, 6, 27),
    'lastUsed': null,
    'expired': true,
  },
]);

final _createdApiKey = jsonEncode({
  'apiKey': {'id': 'key-3', 'name': 'New key', 'timeCreated': _date(2025, 11, 1), 'expired': false},
  'key': 'nsk_plainkeyshownonlyonce',
});

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() async {
    await setupTests(loggedIn: true);
    nock.cleanAll();
  });

  testWidgets('API keys list, create and delete', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/api-keys').reply(200, _apiKeys);

    await tester.pumpWidget(TestSetup(child: ApiKeysSettingsTab()));
    await tester.pumpAndSettle();

    expect(find.text('Home server'), findsOneWidget);
    expect(find.text('Old script'), findsOneWidget);
    expect(find.textContaining('Never expires'), findsOneWidget);
    expect(find.textContaining('Expired on'), findsOneWidget);
    expect(find.textContaining('Never used'), findsOneWidget);
    expect(find.textContaining('Last used'), findsOneWidget);

    await snap(name: 'api_keys', matchToGolden: true);

    // creating a key
    await tester.tap(find.byKey(Key('create-api-key')));
    await tester.pumpAndSettle();

    final confirm = find.byKey(Key('api-key-create-confirm'));
    expect((tester.widget(confirm) as TextButton).enabled, false);

    await tester.enterText(find.byKey(Key('api-key-name')), 'New key');
    await tester.pumpAndSettle();
    expect((tester.widget(confirm) as TextButton).enabled, true);

    // default expiry is relative to today, pick "Never" so the golden stays stable
    await tester.tap(find.byKey(Key('api-key-expiry')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Never').last);
    await tester.pumpAndSettle();
    expect(find.text('Never expires'), findsOneWidget);

    await snap(name: 'api_keys_create_dialog', matchToGolden: true);

    final createKey = nock(validServerUrl).put('/api/api-keys', (body) => true)..reply(200, _createdApiKey);
    nock(validServerUrl).get('/api/api-keys').reply(200, _apiKeys);

    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(createKey.isDone, true);
    expect(find.text('nsk_plainkeyshownonlyonce'), findsOneWidget);

    await snap(name: 'api_keys_created_dialog', matchToGolden: true);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('nsk_plainkeyshownonlyonce'), findsNothing);

    // deleting a key
    final deleteKey = nock(validServerUrl).delete('/api/api-keys/key-1')..reply(200, 'true');
    nock(validServerUrl).get('/api/api-keys').reply(200, '[]');

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    expect(deleteKey.isDone, true);
    expect(find.text("You don't have any API keys yet"), findsOneWidget);
  });
}
