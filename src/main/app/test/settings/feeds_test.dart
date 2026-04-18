import 'dart:convert';

import 'package:app/feed/models/feed_category.dart';
import 'package:app/settings/views/components/feed_category.dart';
import 'package:app/settings/views/tabs/feeds.dart';
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

    nock(validServerUrl).get('/api/users')
      ..reply(200, loadFixture('user.json'))
      ..persist(true);
  });

  testWidgets('Test happy path', (WidgetTester tester) async {
    final interceptor = nock(validServerUrl).get('/api/feeds')..reply(200, loadFixture('feeds.json'));
    final feedCategoryInterceptor = nock(validServerUrl).get('/api/feed-categories')..reply(200, '[]');

    await tester.pumpWidget(TestSetup(child: FeedsSettingsTab()));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorDialog), findsNothing);
    expect(interceptor.isDone, true);
    expect(feedCategoryInterceptor.isDone, true);

    await snap(name: 'feed_settings', matchToGolden: true);
    // one of the feeds has errors so we expect them to show up
    expect(find.textContaining('1337'), findsOneWidget);

    // now we want to add a feed
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    final putFeed = nock(validServerUrl).put('/api/feeds', (body) => true)..reply(200, loadFixture('one_feed.json'));
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, loadFixture('feeds.json'))
      ..persist(true);

    await tester.enterText(textField, "http://someurl.com");
    await tester.tap(find.text('Add feed'));
    await tester.pumpAndSettle();

    expect(putFeed.isDone, true);

    /*
    issue with the delete button not triggering during test only


    final deleteFeed = nock(validServerUrl).delete('/api/feeds/1')..reply(200, 'true');

    final deleteButton = find.byKey(Key('delete_button')).first;
    expect(deleteButton, findsOne);
    await tester.ensureVisible(deleteButton);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();


    final okButton = find.text("Ok");
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    expect(deleteFeed.isDone, true);
*/
  });

  testWidgets('Test URL validation', (WidgetTester tester) async {
    final interceptor = nock(validServerUrl).get('/api/feeds')..reply(200, loadFixture('feeds.json'));
    nock(validServerUrl).get('/api/feed-categories').reply(200, '[]');

    await tester.pumpWidget(TestSetup(child: FeedsSettingsTab()));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorDialog), findsNothing);
    expect(interceptor.isDone, true);

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, "aaaaaa");
    await tester.tap(find.text('Add feed'));
    await tester.pumpAndSettle();

    await snap();

    expect(find.text('Invalid URL'), findsOneWidget);
  });

  testWidgets('test error while loading feeds', (WidgetTester tester) async {
    final interceptor = nock(validServerUrl).get('/api/feeds')..reply(500, '');
    nock(validServerUrl).get('/api/feed-categories').reply(200, '[]');

    await tester.pumpWidget(TestSetup(child: FeedsSettingsTab()));
    await tester.pumpAndSettle();

    await snap();

    expect(find.byType(ErrorDialog), findsOneWidget);
    expect(interceptor.isDone, true);
  });

  testWidgets('test add feed category button when no feeds', (WidgetTester tester) async {
    var feedInterceptor = nock(validServerUrl).get('/api/feeds')..reply(200, '[]');
    var feedCategoryInterceptor = nock(validServerUrl).get('/api/feed-categories')..reply(200, '[]');

    await tester.pumpWidget(TestSetup(child: FeedsSettingsTab()));
    await tester.pumpAndSettle();

    expect(feedInterceptor.isDone, true);
    expect(feedCategoryInterceptor.isDone, true);

    await snap();

    final addCategoryButton = find.byKey(Key('add-category'));
    expect(addCategoryButton, findsNothing);
  });

  testWidgets('test add feed category button when user has feeds', (WidgetTester tester) async {
    var feedInterceptor = nock(validServerUrl).get('/api/feeds')..reply(200, loadFixture('feeds.json'));
    var feedCategoryInterceptor = nock(validServerUrl).get('/api/feed-categories')..reply(200, '[]');

    final addCategoryButton = find.byKey(Key('add-category'));
    expect(addCategoryButton, findsNothing);

    await tester.pumpWidget(TestSetup(child: FeedsSettingsTab()));
    await tester.pumpAndSettle();

    expect(feedInterceptor.isDone, true);
    expect(feedCategoryInterceptor.isDone, true);

    expect(addCategoryButton, findsOneWidget);

    await tester.tap(addCategoryButton);
    await tester.pumpAndSettle();

    await snap();

    final nameTextField = find.byKey(Key('input-textfield'));
    expect(nameTextField, findsOneWidget);

    await tester.enterText(nameTextField, 'cat1');
    await tester.pumpAndSettle();

    final putFeedCategory = nock(validServerUrl).put('/api/feed-categories', (body) => true)
      ..reply(200, jsonEncode(FeedCategory(name: 'cat1', id: 'cat1-id').toJson()));

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    expect(putFeedCategory.isDone, true);
    await snap(name: 'new_feed_category');

    // there should be a single delete button as the uncategorized category can't be deleted
    final cat1 = find.text('cat1');
    final uncategorized = find.text('Uncategorized');
    final deleteButton = find.text('Delete');

    expect(cat1, findsOneWidget);
    expect(deleteButton, findsOneWidget);
    expect(uncategorized, findsOneWidget);

    // now we test the hide / show
    final arsTechnicaFeed = find.text('Ars Technica - All content');
    expect(arsTechnicaFeed, findsOneWidget);

    await tester.tap(uncategorized);
    await tester.pumpAndSettle();
    expect(arsTechnicaFeed, findsNothing);

    await tester.tap(uncategorized);
    await tester.pumpAndSettle();
    expect(arsTechnicaFeed, findsOneWidget);

    // we drag a feed to cat1
    final dragHandle = find.byIcon(Icons.drag_handle).first;
    expect(dragHandle, findsOneWidget);

    final Offset sourceLocation = tester.getCenter(dragHandle);
    final Offset targetLocation = tester.getCenter(cat1);
    final Offset delta = targetLocation - sourceLocation;

    // when we end the drag, we don't care about the result post as long as it's not an error.
    var interceptor = nock(validServerUrl).post('/api/feeds', (body) => true)..reply(200, '{}');

    await tester.drag(dragHandle, delta);
    await tester.pumpAndSettle();

    await snap(name: 'after_drag_feed_into_category');

    expect(interceptor.isDone, true);

    final categories = find.byType(FeedCategoryView);
    expect(categories, findsNWidgets(2));

    // we count feeds in each categories
    final uncategorizedFeeds = find.descendant(of: categories.first, matching: find.byIcon(Icons.drag_handle));
    final cat1Feeds = find.descendant(of: categories.last, matching: find.byIcon(Icons.drag_handle));

    expect(uncategorizedFeeds, findsNWidgets(3));
    expect(cat1Feeds, findsNWidgets(1));
  });
}
