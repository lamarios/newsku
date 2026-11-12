import 'package:app/user/views/components/signup_form.dart';
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
    await setupTests();
    nock.cleanAll();
  });

  testWidgets('Test sign up form validation', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: SignupFormScreen()));

    final signUpButton = find.byKey(Key('signup-button'));
    expect(signUpButton, findsOneWidget);
    FilledButton signupButtonWidget = tester.widget(signUpButton);

    expect(signupButtonWidget.enabled, false);

    final username = find.byKey(Key('username-field'));
    final email = find.byKey(Key('email-field'));
    final password = find.byKey(Key('password-field'));
    final repeatPassword = find.byKey(Key('repeat-password-field'));

    expect(username, findsOneWidget);
    expect(email, findsOneWidget);
    expect(password, findsOneWidget);
    expect(repeatPassword, findsOneWidget);

    await tester.enterText(username, 'test');
    await tester.enterText(email, "valid@valid.com");
    await tester.enterText(password, 'aaa');
    await tester.enterText(repeatPassword, 'aaa');

    await tester.pumpAndSettle();

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, true);

    // now we check the validation
    await tester.enterText(username, '');
    await tester.pumpAndSettle();

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, false);

    await tester.enterText(username, 'test');

    //testing invalid email
    await tester.enterText(email, 'invalid email');
    await tester.pumpAndSettle();

    expect(find.text('Invalid email'), findsOneWidget);

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, false);

    await tester.enterText(email, '');
    await tester.pumpAndSettle();

    expect(find.text('Invalid email'), findsNothing);

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, false);

    await tester.enterText(email, 'valid@valid.com');
    await tester.enterText(password, 'bbb');
    await tester.pumpAndSettle();

    final passwordNotMatch = find.text('Passwords do not match');
    expect(passwordNotMatch, findsOneWidget);

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, false);

    await tester.enterText(password, 'aaa');
    await tester.pumpAndSettle();

    expect(passwordNotMatch, findsNothing);

    signupButtonWidget = tester.widget(signUpButton);
    expect(signupButtonWidget.enabled, true);

    final signupInterceptor = nock(validServerUrl).put('/signup', (body) => true)..reply(200, loadFixture('user.json'));

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(signupInterceptor.isDone, true);
  });
}
