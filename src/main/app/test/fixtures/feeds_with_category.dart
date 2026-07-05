import 'dart:convert';

import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';

var feedsWithCategories = jsonEncode([
  Feed(id: 'aaaa', name: 'My super feed', url: 'https://google.com', description: 'the super test feed').toJson(),
  Feed(
    id: 'bbbb',
    name: 'My super categorised feed',
    url: 'https://arstechnica.com',
    description: 'the super test feed',
    category: FeedCategory(name: 'Tech stuff', id: '111'),
  ).toJson(),
]);
