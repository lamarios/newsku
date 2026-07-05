import 'package:app/feed/views/components/search_result.dart';
import 'package:app/feed/views/screens/feed_screen.dart';
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

  testWidgets('Test search', (WidgetTester tester) async {
    nock(validServerUrl).get('/api/layout')
      ..reply(200, loadFixture('default_layout.json'))
      ..persist(true);
    nock(validServerUrl).get('/api/feeds')
      ..reply(200, '[]')
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
    await tester.pumpAndSettle();

    final searchButton = find.byIcon(Icons.search);
    final textField = find.byType(TextField);
    final closeSearch = find.byIcon(Icons.close);
    expect(searchButton, findsOneWidget);
    expect(textField, findsNothing);
    expect(closeSearch, findsNothing);

    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    final searchInterceptor = nock(validServerUrl).get('/api/search')
      ..query((Map<String, String> params) => true)
      ..reply(200, loadFixture('search_result.json'));

    expect(searchButton, findsNothing);
    expect(textField, findsOneWidget);
    expect(closeSearch, findsOneWidget);

    await snap(name: 'search');
    await tester.enterText(textField, 'some random search');
    // we have a debounce on the search bar
    await tester.pump(Duration(milliseconds: 500));

    expect(searchInterceptor.isDone, true);

    await snap(name: 'search_results', matchToGolden: true);

    // no need to test individual search result content, we already have a test for each block type
    expect(find.byType(SearchResult), findsNWidgets(2));

    // testing closing the search
    await tester.tap(closeSearch);
    await tester.pumpAndSettle();

    expect(searchButton, findsOneWidget);
    expect(textField, findsNothing);
    expect(closeSearch, findsNothing);
  });
}
