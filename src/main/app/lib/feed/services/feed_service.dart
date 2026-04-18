import 'dart:convert';
import 'dart:typed_data';

import 'package:app/base_service.dart';
import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_error.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/utils/models/pagination.dart';
import 'package:http/http.dart' as http;

class FeedService extends BaseService {
  @override
  final String url;

  const FeedService(this.url);

  Future<void> deleteFeed(String id) async {
    var uri = await formatUrl('/api/feeds/$id');

    var response = await http.delete(uri, headers: await headers);
    processResponse(response);
  }

  Future<Paginated<FeedError>> getErrors({required String feedId, required int page, required int pageSize}) async {
    var uri = await formatUrl('/api/feed-errors/$feedId', query: {'page': page, 'pageSize': pageSize});

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    Map<String, dynamic> json = jsonDecode(response.body);

    return Paginated<FeedError>.fromJson(json, (feedItem) => FeedError.fromJson(feedItem as Map<String, dynamic>));
  }

  Future<Feed> updateFeed(Feed feed) async {
    var uri = await formatUrl('/api/feeds');

    var response = await http.post(uri, headers: await headers, body: jsonEncode(feed));

    processResponse(response);

    Map<String, dynamic> updated = jsonDecode(response.body);

    return Feed.fromJson(updated);
  }

  Future<int> countLast24Hours() async {
    var uri = await formatUrl('/api/feed-errors/last-refresh-count');
    var response = await http.get(uri, headers: await headers);
    processResponse(response);

    return jsonDecode(response.body);
  }

  Future<List<Feed>> getFeeds() async {
    var uri = await formatUrl('/api/feeds');

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    Iterable i = jsonDecode(response.body);

    return i.map((e) => Feed.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Feed> addFeed(String url) async {
    var uri = await formatUrl('/api/feeds');

    var response = await http.put(uri, headers: await headers, body: url);

    processResponse(response);

    Map<String, dynamic> feed = jsonDecode(response.body);

    return Feed.fromJson(feed);
  }

  Future<void> click(String id) async {
    var uri = await formatUrl('/api/feeds/items/$id/click');

    var response = await http.put(uri, headers: await headers, body: url);

    processResponse(response);
  }

  Future<Paginated<FeedItem>> getFeedItems({
    required int page,
    required int pageSize,
    required int from,
    required int to,
  }) async {
    var uri = await formatUrl('/api/feeds/items', query: {'page': page, 'pageSize': pageSize, 'from': from, 'to': to});

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    Map<String, dynamic> json = jsonDecode(response.body);

    return Paginated<FeedItem>.fromJson(json, (feedItem) => FeedItem.fromJson(feedItem as Map<String, dynamic>));
  }

  Future<List<FeedItem>> search({required String query, int page = 0, int pageSize = 100}) async {
    var uri = await formatUrl('/api/search', query: {'page': page, 'pageSize': pageSize, 'query': query});

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    Iterable json = jsonDecode(response.body);

    return json.map((e) => FeedItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Uint8List> exportFeeds() async {
    var uri = await formatUrl('/api/feeds/export');

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    return response.bodyBytes;
  }

  Future<List<Feed>> importFeeds(Uint8List bytes) async {
    var uri = await formatUrl('/api/feeds/import');

    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(await headers)
      ..files.add(http.MultipartFile.fromBytes('file', bytes, filename: 'feeds.opml'));
    var response = await http.Response.fromStream(await request.send());

    processResponse(response);
    Iterable i = jsonDecode(response.body);

    return i.map((e) => Feed.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> readItems(List<String> itemIds) async {
    var uri = await formatUrl('/api/feeds/items/read');

    var response = await http.post(uri, headers: await headers, body: jsonEncode(itemIds));

    processResponse(response);
  }

  Future<List<FeedCategory>> getFeedCategories() async {
    var uri = await formatUrl('/api/feed-categories');

    var response = await http.get(uri, headers: await headers);

    processResponse(response);

    Iterable i = jsonDecode(response.body);

    return i.map((e) => FeedCategory.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<FeedCategory> addFeedCategory(String name) async {
    var uri = await formatUrl('/api/feed-categories');

    var response = await http.put(uri, headers: await headers, body: name);

    processResponse(response);

    Map<String, dynamic> feed = jsonDecode(response.body);

    return FeedCategory.fromJson(feed);
  }

  Future<FeedCategory> updateFeedCategory(FeedCategory category) async {
    var uri = await formatUrl('/api/feed-categories');

    var response = await http.post(uri, headers: await headers, body: jsonEncode(category));

    processResponse(response);

    Map<String, dynamic> feed = jsonDecode(response.body);

    return FeedCategory.fromJson(feed);
  }

  Future<void> deleteFeedCategory(String id) async {
    var uri = await formatUrl('/api/feed-categories/$id');

    var response = await http.delete(uri, headers: await headers);
    processResponse(response);
  }
}
