import 'package:app/settings/views/tabs/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:snaptest/snaptest.dart';

import '../helper_widget/test_app_setup_widget.dart';
import '../test_utils.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() async {
    await setupTests(loggedIn: true);
    nock.cleanAll();
  });

  testWidgets('User test happy path', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    await snap(name: 'user_settings', matchToGolden: false);

    var updateUser = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    expect((tester.widget(find.byKey(Key('email'))) as TextField).controller?.text, 'test@test.com');

    await tester.tap(find.text('Update').first);
    await tester.pumpAndSettle();

    expect(updateUser.isDone, true);

    var passwordUpdateButton = find.byKey(Key('password-update-button'));
    expect(passwordUpdateButton, findsOneWidget);

    updateUser = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, false);

    await tester.enterText(find.byKey(Key('new-password')), 'aaa');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('repeat-password')), 'aaa');
    await tester.pumpAndSettle();
    await snap(name: 'after_password_input');

    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, true);

    await tester.tap(passwordUpdateButton);
    await tester.pumpAndSettle();
    expect(updateUser.isDone, true);
  });

  testWidgets('Test email validation', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    final emailField = find.byKey(Key('email'));

    await tester.enterText(emailField, 'aaaaa');
    await tester.pumpAndSettle();

    expect(find.text('Invalid email'), findsOneWidget);

    await tester.enterText(emailField, 'aaaa@tafsdfas.com');
    await tester.pumpAndSettle();

    expect(find.text('Invalid email'), findsNothing);
  });

  testWidgets('Test password validation', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    final passwordField = find.byKey(Key('new-password'));
    final repeatPasswordField = find.byKey(Key('repeat-password'));
    final passwordUpdateButton = find.byKey(Key('password-update-button'));
    final errorText = find.text('Passwords do not match');

    await tester.enterText(passwordField, 'text');
    await tester.pumpAndSettle();
    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, false);
    expect(errorText, findsOneWidget);

    await tester.enterText(repeatPasswordField, 'different  text');
    await tester.pumpAndSettle();

    expect(errorText, findsOneWidget);
    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, false);

    await tester.enterText(passwordField, '');
    await tester.pumpAndSettle();

    expect(errorText, findsOneWidget);
    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, false);

    await tester.enterText(passwordField, 'different  text');
    await tester.pumpAndSettle();

    // the error should disappear as now passwords are the same
    expect(errorText, findsNothing);
    expect((tester.widget(passwordUpdateButton) as FilledButton).enabled, true);
  });
}
