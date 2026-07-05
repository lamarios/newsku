import 'dart:convert';

import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/big_grid_item.dart';
import 'package:app/feed/views/components/headline.dart';
import 'package:app/feed/views/components/small_grid_item.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/home/views/components/feeds_drawer.dart';
import 'package:app/user/views/components/user_profile_picture.dart';
import 'package:app/utils/models/pagination.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:snaptest/snaptest.dart';

import '../fixtures/feeds_with_category.dart';
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
      ..reply(200, jsonEncode([FeedCategory(id: '111', name: 'Tech stuff').toJson()]))
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
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
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

    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
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
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
      ..persist(true);
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
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
      ..persist(true);
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
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
      ..persist(true);
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
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
      ..persist(true);
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

  testWidgets('Test feed drawer', (tester) async {
    nock(validServerUrl).get('/api/layout')
      ..reply(200, loadFixture('default_layout.json'))
      ..persist(true);
    nock(validServerUrl).get('/api/feed-errors/last-refresh-count')
      ..reply(200, '0')
      ..persist(true);

    nock(validServerUrl).get('/api/feeds')
      ..reply(200, feedsWithCategories)
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

    final feedDrawer = find.byType(FeedsDrawer);

    expect(feedDrawer, findsOne);
    expect(feedDrawer.hitTestable(), findsNothing);

    final drawerButton = find.byKey(Key('drawer-button'));

    await tester.tap(drawerButton);
    await tester.pumpAndSettle();

    await snap(name: 'drawer_opened', matchToGolden: true);
    expect(feedDrawer.hitTestable(), findsOne);

    // now we check the content of the drawer
    // we should find 2 feed categories (Uncategorized and 'tech stuff')
    expect(find.text('Tech stuff'), findsOne);
    expect(find.text('Uncategorized'), findsOne);

    // then our 2 feeds
    var feed = find.text('My super feed');
    expect(feed, findsOne);
    expect(find.text('My super categorised feed'), findsOne);

    nock(validServerUrl).post('/api/feeds/items/read', anyQuery)
      ..reply(200, '')
      ..persist(true);

    final feedCall = nock(validServerUrl).get('/api/feeds/aaaa/items')
      ..query(anyQuery)
      ..reply(
        200,
        jsonEncode(
          Paginated<FeedItem>(
            content: [
              FeedItem(
                id: 'fsdfs',
                title: 'item 1',
                description: 'description 1',
                content: 'content 1',
                feed: Feed(id: 'aaa'),
              ),
              FeedItem(
                id: 'fss',
                title: 'item 2',
                description: 'description 2',
                content: 'content 2',
                feed: Feed(id: 'aaa'),
              ),
            ],
          ).toJson((p0) => p0.toJson()),
        ),
      );

    await tester.tap(feed);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));

    await snap(name: 'single_feed_view', matchToGolden: true);

    expect(feedCall.isDone, true);

    expect(find.text('item 1'), findsOne);
    expect(find.text('item 2'), findsOne);
  });
}
