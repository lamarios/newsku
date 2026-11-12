import 'dart:convert';

import 'package:app/settings/views/tabs/user.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  testWidgets('Unlink SSO account', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final unlinkedUser = jsonDecode(loadFixture('user.json'))..remove('oidcSub');

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    // the user from the fixture is linked to the test OIDC provider
    expect(find.text('Single sign-on (Test OIDC)'), findsOneWidget);
    expect(find.byKey(Key('sso-link-button')), findsNothing);

    nock.cleanAll();
    nock(validServerUrl).get('/api/users')
      ..reply(200, jsonEncode(unlinkedUser))
      ..persist(true);
    final unlinkAgain = nock(validServerUrl).delete('/api/users/oidc')..reply(200, jsonEncode(unlinkedUser));

    // cancelling the confirmation doesn't unlink
    await tester.tap(find.byKey(Key('sso-unlink-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(unlinkAgain.isDone, false);

    await tester.tap(find.byKey(Key('sso-unlink-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('sso-unlink-confirm')));
    await tester.pumpAndSettle();

    expect(unlinkAgain.isDone, true);
    expect(find.byKey(Key('sso-unlink-button')), findsNothing);
    expect(find.byKey(Key('sso-link-button')), findsOneWidget);
  });

  testWidgets('Update errors are shown', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    final updateUser = nock(validServerUrl).post('/api/users', (body) => true)
      ..reply(400, jsonEncode({'message': 'Email already in use', 'type': 'NewskuUserException', 'uuid': 'some-uuid'}));

    await tester.tap(find.text('Update').first);
    await tester.pumpAndSettle();

    expect(updateUser.isDone, true);
    expect(find.text('Email already in use'), findsOneWidget);
    expect(find.text('Email updated'), findsNothing);
  });

  testWidgets('Password change stores the new token', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: UserSettingsTab()));
    await tester.pumpAndSettle();

    final updateUser = nock(validServerUrl).post('/api/users', (body) => true)
      ..reply(200, loadFixture('user.json'), headers: {'x-new-token': 'new-token'});

    await tester.enterText(find.byKey(Key('new-password')), 'aaa');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('repeat-password')), 'aaa');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('password-update-button')));
    await tester.pumpAndSettle();

    expect(updateUser.isDone, true);
    expect(identityCubit.state.token, 'new-token');
    expect((await SharedPreferences.getInstance()).getString('token'), 'new-token');
    expect(find.text('Password updated'), findsOneWidget);
  });
}
