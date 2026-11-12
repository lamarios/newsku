import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/big_grid_item.dart';
import 'package:app/feed/views/components/big_grid_picture_item.dart';
import 'package:app/feed/views/components/headline.dart';
import 'package:app/feed/views/components/headline_picture.dart';
import 'package:app/feed/views/components/search_result.dart';
import 'package:app/feed/views/components/small_grid_item.dart';
import 'package:app/feed/views/components/top_stories.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/models/layout_block_settings.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:snaptest/snaptest.dart';

import '../helper_widget/test_app_setup_widget.dart';
import '../test_utils.dart';

final _basicItem = FeedItem(
  id: 'aaaa',
  guid: 'aaa',
  url: 'http://test.com/aaa',
  description: 'item description',
  content: 'item content',
  reasoning: 'My reasoning',
  importance: 50,
  timeCreated: DateTime.utc(2026, 1, 1, 0, 0, 0).millisecondsSinceEpoch,
  title: 'My title',
  read: true,
  tags: ['tag1', 'tag2'],
  feed: Feed(id: 'feed-id', name: 'feed name'),
);

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() async {
    await setupTests(loggedIn: true);
    nock.cleanAll();
  });

  testWidgets('Test top stories', (WidgetTester tester) async {
    var items = [
      _basicItem.copyWith(id: '1', title: 'title1', description: 'description1', importance: 100),
      _basicItem.copyWith(id: '2', title: 'title2', description: 'description1', importance: 99),
      _basicItem.copyWith(id: '3', title: 'title3', description: 'description1', importance: 98),
      _basicItem.copyWith(id: '4', title: 'title4', description: 'description1', importance: 97),
    ];

    await tester.pumpWidget(
      TestSetup(
        child: TopStories(
          items: items,
          block: LayoutBlock(
            type: .topStories,
            order: 1,
            settings: LayoutBlockSettings(title: 'block title'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await snap(name: 'top_stories', matchToGolden: true);

    await _testFeedArticle(tester, items[0], parent: find.byKey(Key('top-stories-headline')));
    await _testFeedArticle(tester, items[1], testDescription: false, parent: find.byKey(Key('top-stories-0')));
    await _testFeedArticle(tester, items[2], testDescription: false, parent: find.byKey(Key('top-stories-1')));
    await _testFeedArticle(tester, items[3], testDescription: false, parent: find.byKey(Key('top-stories-2')));

    expect(find.text('block title'), findsOneWidget);
  });

  // in this file we will test all the display of all the different types of block items
  testWidgets('Test search result', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: SearchResult(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'search_result', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(SearchResult));
  });

  testWidgets('Test big grid picture', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: BigGridPictureItem(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'big_grid_picture', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(BigGridPictureItem));
  });

  testWidgets('Test small grid', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: SmallGridItem(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'small_grid', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(SmallGridItem));
  });

  testWidgets('Test big grid item', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: BigGridItem(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'big_grid', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(BigGridItem));
  });

  testWidgets('Test picture headline', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: HeadlinePicture(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'big_headline_picture', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(HeadlinePicture));
  });

  testWidgets('Test headline', (WidgetTester tester) async {
    await tester.pumpWidget(TestSetup(child: Headline(item: _basicItem)));
    await tester.pumpAndSettle();

    await snap(name: 'big_headline', matchToGolden: true);

    await _testFeedArticle(tester, _basicItem, parent: find.byType(Headline));
  });
}

Future<void> _testFeedArticle(
  WidgetTester tester,
  FeedItem item, {
  required Finder parent,
  bool testDescription = true,
}) async {
  expect(find.descendant(of: parent, matching: find.text(item.title!)), findsOneWidget);
  if (testDescription) {
    expect(find.text(item.description!), findsOneWidget);
  }
  expect(find.descendant(of: parent, matching: find.text(item.importance.toString())), findsOneWidget);
  expect(find.descendant(of: parent, matching: find.text(item.feed!.name!)), findsOneWidget);
  for (var tag in item.tags) {
    expect(find.descendant(of: parent, matching: find.text(tag)), findsOneWidget);
  }

  var date = DateTime.fromMillisecondsSinceEpoch(item.timeCreated);
  expect(find.descendant(of: parent, matching: find.text(articleDateFormat.format(date))), findsOneWidget);

  // test clicking on score
  await tester.tap(find.descendant(of: parent, matching: find.byKey(Key('reasoning-button'))));
  await tester.pumpAndSettle();
  expect(find.byType(AlertDialog), findsOneWidget);
  expect(find.text('Reasoning'), findsOneWidget);
  expect(find.text(item.reasoning!), findsOneWidget);

  await tester.tap(find.text('Ok'));
  await tester.pumpAndSettle();
  expect(find.descendant(of: parent, matching: find.byType(AlertDialog)), findsNothing);
}
