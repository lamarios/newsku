import 'package:app/identity/views/components/first_time_setup_trigger.dart';
import 'package:app/utils/utils.dart';
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

  testWidgets('Test where the first time setup dialog do not show up if not needed', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestSetup(
        child: FirstTimeSetupTrigger(key: Key('no-set-up'), child: Placeholder()),
      ),
    );
    await tester.pumpAndSettle();
    // await snap();
    final dialog = find.byType(Dialog);
    expect(find.descendant(of: dialog, matching: find.textContaining('Welcome to Newsku!')), findsNothing);
  });

  testWidgets('Test if the first time setup dialog shows up', (WidgetTester tester) async {
    // first we make sure the user hasn't done the first time login
    final userInterceptor = nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user_first_time_setup.json'));
    await identityCubit.setToken(generateTestUserToken());
    expect(userInterceptor.isDone, true);
    expect(identityCubit.currentUser?.firstTimeSetupDone, false);

    await tester.pumpWidget(TestSetup(child: FirstTimeSetupTrigger(child: Placeholder())));
    await tester.pumpAndSettle();

    final dialog = find.byType(Dialog);
    expect(dialog, findsOneWidget);
    expect(find.descendant(of: dialog, matching: find.textContaining('Welcome to Newsku!')), findsOneWidget);
  });

  testWidgets('Test the proper walkthrough of the first time setup to make sure all steps work fine', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(Size(1000, 1300));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final userInterceptor = nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user_first_time_setup.json'));
    await identityCubit.setToken(generateTestUserToken());
    expect(userInterceptor.isDone, true);
    expect(identityCubit.currentUser?.firstTimeSetupDone, false);

    await tester.pumpWidget(TestSetup(child: FirstTimeSetupTrigger(child: Placeholder())));
    await tester.pumpAndSettle();

    final dialog = find.byType(Dialog);
    final nextButton = find.descendant(of: dialog, matching: find.byKey(Key('next')));
    final backButton = find.descendant(of: dialog, matching: find.byKey(Key('back')));
    final doneButton = find.descendant(of: dialog, matching: find.byKey(Key('done')));

    // in the first step we should just have the welcome text
    expect(find.descendant(of: dialog, matching: find.textContaining('Welcome to Newsku!')), findsOneWidget);

    expect(nextButton, findsOneWidget);
    expect(backButton, findsOneWidget);
    expect(doneButton, findsNothing);
    TextButton backButtonWidget = tester.widget(backButton);

    expect(backButtonWidget.enabled, false);

    await snap(name: 'first_time_set_up_page_1', matchToGolden: true);

    final feedsInterceptor = nock(validServerUrl).get('/api/feeds')..reply(200, '[]');
    var feedCategoryInterceptor = nock(validServerUrl).get('/api/feed-categories')..reply(200, '[]');

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    // Feeds page
    final feedsTitle = find.descendant(of: dialog, matching: find.text('Feeds'));
    expect(feedsTitle, findsOneWidget);
    expect(feedsInterceptor.isDone, true);
    expect(feedCategoryInterceptor.isDone, true);

    // now, we should be able to go back
    expect(nextButton, findsOneWidget);
    expect(backButton, findsOneWidget);
    expect(doneButton, findsNothing);
    backButtonWidget = tester.widget(backButton);
    expect(backButtonWidget.enabled, true);

    await snap(name: 'first_time_set_up_page_2', matchToGolden: true);

    await tester.pumpAndSettle();
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    // Article preference page
    final preferenceTitle = find.descendant(of: dialog, matching: find.text('Article preferences'));
    expect(preferenceTitle, findsOneWidget);

    expect(nextButton, findsOneWidget);
    expect(backButton, findsOneWidget);
    expect(doneButton, findsNothing);
    backButtonWidget = tester.widget(backButton);
    expect(backButtonWidget.enabled, true);

    // Layout page
    // the next screen is going to try to get the default layout so we mock it
    final layoutInterceptor = nock(validServerUrl).get('/api/layout')..reply(200, loadFixture('default_layout.json'));
    final firstLayoutSaveInterceptor = nock(validServerUrl).put('/api/layout', (body) => true)
      ..reply(200, loadFixture('default_layout.json'));
    feedCategoryInterceptor = nock(validServerUrl).get('/api/feed-categories')..reply(200, '[]');

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    await snap(name: 'first_time_set_up_page_3', matchToGolden: true);

    expect(layoutInterceptor.isDone, true);
    expect(firstLayoutSaveInterceptor.isDone, true);
    expect(feedCategoryInterceptor.isDone, true);

    final layoutTitle = find.descendant(of: dialog, matching: find.text('Layout'));
    expect(layoutTitle, findsOneWidget);

    await tester.tapAt(Offset(0, 0)); // tap somewhere to otherwise tapping the button again does not seem to work
    await tester.pumpAndSettle();
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    await snap(name: 'first_time_set_up_page_4', matchToGolden: true);

    final setupComplete = find.descendant(of: dialog, matching: find.text('Setup complete !'));
    expect(setupComplete, findsOneWidget);

    expect(nextButton, findsNothing);
    expect(backButton, findsOneWidget);
    expect(doneButton, findsOneWidget);
    backButtonWidget = tester.widget(backButton);
    expect(backButtonWidget.enabled, true);

    final setupUser = nock(validServerUrl).post('/api/users', (body) => true)..reply(200, loadFixture('user.json'));

    await tester.tapAt(Offset(0, 0)); // tap somewhere to otherwise tapping the button again does not seem to work
    await tester.pumpAndSettle();
    await tester.tap(doneButton);
    await tester.pumpAndSettle();

    expect(setupUser.isDone, true);
    expect(dialog, findsNothing);
    await snap(name: 'first_time_set_up_done', matchToGolden: true);
  });
}
