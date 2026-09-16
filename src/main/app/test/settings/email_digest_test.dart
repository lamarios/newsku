import 'package:app/settings/views/tabs/email_digest.dart';
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

  testWidgets('Digest test happy path', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(Size(1000, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: EmailDigestTab()));
    await tester.pumpAndSettle();

    await snap(name: 'email_diguest', matchToGolden: false);

    var updateUser = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    await tester.tap(find.text('Weekly'));
    await tester.pumpAndSettle();
    expect(updateUser.isDone, true);

    updateUser = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

  });

}
