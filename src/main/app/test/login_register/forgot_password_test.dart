import 'package:app/user/views/components/forgot_password.dart';
import 'package:material_ui/material_ui.dart';
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
    await setupTests();
    nock.cleanAll();
  });

  testWidgets('Test forgot password validation', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: ForgotPasswordScreen()));

    final email = find.byKey(Key('email'));
    final submit = find.byKey(Key('submit'));

    expect(email, findsOneWidget);
    expect(submit, findsOneWidget);

    await tester.enterText(email, 'aaaaaa');
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(find.text('Invalid email'), findsOneWidget);

    await tester.enterText(email, 'valid@valid.com');

    final interceptor = nock(validServerUrl).post('/forgot-password', (body) => true)..reply(200, '');

    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(interceptor.isDone, true);

    final barrier = find.byType(ModalBarrier);
    final dialog = find.byType(AlertDialog);

    final dialogTest = find.descendant(of: dialog, matching: find.text('Password reset request submitted'));

    expect(barrier, findsAtLeastNWidgets(1));
    expect(dialog, findsAtLeastNWidgets(1));
    expect(dialogTest, findsOneWidget);

    await snap();
  });
}
