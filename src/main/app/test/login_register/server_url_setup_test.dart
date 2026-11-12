// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/user/views/components/server_url.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

import '../helper_widget/test_app_setup_widget.dart';
import '../test_utils.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() async {
    await setupTests(withConfig: false);
    nock.cleanAll();
  });

  testWidgets('Test setting up the server url', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestSetup(child: ServerUrlScreen()));

    // Verify that our counter starts at 0.
    expect(find.text('Server'), findsOneWidget);
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    final wrongServerUrl = "http://localhost:111";
    nock(wrongServerUrl).get("/config").reply(404, '');

    nock(validServerUrl).get('/config').reply(200, loadFixture('valid_server_config.json'));

    // let's do a simple test with an invalid server for example
    await tester.enterText(textField, wrongServerUrl);
    await tester.pump(const Duration(milliseconds: 600));

    await tester.pumpAndSettle();

    var error = find.text('Couldn\'t read server or get its config');
    expect(error, findsOneWidget);

    var continueButton = find.byKey(Key('continue-button'));
    FilledButton continueButtonWidget = tester.widget(continueButton);

    expect(continueButtonWidget.enabled, isFalse);

    await tester.enterText(textField, validServerUrl);
    await tester.pump(const Duration(milliseconds: 600));

    await tester.pumpAndSettle();

    error = find.text('Couldn\'t read server or get its config');
    expect(error, findsNothing);

    continueButtonWidget = tester.widget(continueButton);

    expect(continueButtonWidget.enabled, isTrue);

    await tester.tap(continueButton);
    await tester.pumpAndSettle();

    expect(validServerUrl, identityCubit.state.serverUrl);
  });
}
