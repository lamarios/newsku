import 'package:app/feed/views/components/big_grid_item.dart';
import 'package:app/feed/views/components/headline.dart';
import 'package:app/feed/views/components/small_grid_item.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/user/views/components/user_profile_picture.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_dialog.dart';
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

    nock(validServerUrl).get('/api/feed-categories')
      ..reply(200, '[]')
      ..persist(true);
  });

  testWidgets('Test whether demo mode removes the settings button properly', (WidgetTester tester) async {
    // mock layout
    nock(validServerUrl).get('/api/layout')
      ..reply(200, loadFixture('default_layout.json'))
      ..persist(true);
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count')
      ..reply(200, '0')
      ..persist(true);
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, '{"content":[]}')
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: FeedScreen()));

    await snap(name: 'feed_app_bar', from: find.byKey(Key('app-bar')), matchToGolden: true);

    final profileButton = find.byKey(Key('profile-button'));
    expect(profileButton, findsOneWidget);

    await tester.tap(profileButton);
    await tester.pumpAndSettle();

    final settingsButton = find.descendant(of: profileButton, matching: find.byKey(Key('settings-button')));

    expect(settingsButton, findsOneWidget);

    // now we do the same but we set the app as demo mode
    // and the settings button should disappear
    identityCubit.setUrl(validServerUrl, config: identityCubit.state.config!.copyWith(demoMode: true));
    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.tap(profileButton);
    await tester.pumpAndSettle();
    expect(settingsButton, findsNothing);
  });

  testWidgets('Test whether getting feed data will actually display something', (WidgetTester tester) async {
    // this should be big enough for one day of feed
    await tester.binding.setSurfaceSize(Size(800, 3000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    nock(validServerUrl).get('/api/layout')
      ..reply(200, loadFixture('default_layout.json'))
      ..persist(true);
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count')
      ..reply(200, '0')
      ..persist(true);

    // we just load one day of data
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, loadFixture('one_day_feed_content.json'));
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, '{"content":[]}')
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.pumpAndSettle();

    await snap(name: 'one_day_default_layout', matchToGolden: true);

    final headline = find.byType(Headline);
    final bigGridItem = find.byType(BigGridItem);
    final smallGridItem = find.byType(SmallGridItem);

    // testing our default layout
    expect(headline, findsAtLeastNWidgets(1));
    expect(bigGridItem, findsNWidgets(6));
    expect(smallGridItem, findsNWidgets(5));

    final titles = find.byKey(Key('item-title'));

    expect(titles, findsNWidgets(12));

    // now we check if the items are in order of descending score
    Iterable<Text> titleTexts = tester.widgetList(titles);

    int currentScore =
        105; // we start higher than what an item could be scored, and we make sure we're always going down
    for (var title in titleTexts) {
      var score = int.parse((title.data ?? '').split(': ')[1]);
      print('score: $score');
      expect(score < currentScore, true);
      currentScore = score;
    }
  });

  testWidgets('Test error getting layout', (WidgetTester tester) async {
    nock(validServerUrl).get('/api/layout').reply(500, '');
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count').reply(200, '0');
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, '{"content":[]}');

    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.pumpAndSettle();
    await snap();

    expect(find.byType(ErrorDialog), findsOneWidget);
  });

  testWidgets('Test error getting error count', (WidgetTester tester) async {
    nock(validServerUrl).get('/api/layout').reply(200, loadFixture('default_layout.json'));
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count').reply(500, '');
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, '{"content":[]}')
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.pumpAndSettle();
    await snap();

    expect(find.byType(ErrorDialog), findsOneWidget);
  });

  testWidgets('Test error getting feed', (WidgetTester tester) async {
    nock(validServerUrl).get('/api/layout').reply(200, loadFixture('default_layout.json'));
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count').reply(200, '0');
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(500, '')
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.pumpAndSettle();
    await snap();

    expect(find.byType(ErrorDialog), findsOneWidget);
  });

  testWidgets('Test feed error count badge', (WidgetTester tester) async {
    nock(validServerUrl).get('/api/layout').reply(200, loadFixture('default_layout.json'));
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count').reply(200, '1337');
    nock(validServerUrl).get('/api/feeds/items')
      ..query((Map<String, String> params) {
        return true;
      })
      ..reply(200, '{"content":[]}')
      ..persist(true);

    await tester.pumpWidget(TestSetup(child: FeedScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(UserProfilePicture));
    await tester.pumpAndSettle();
    await snap(name: 'feeds_error_badge');

    expect(find.text('1337'), findsOneWidget);
  });
}
