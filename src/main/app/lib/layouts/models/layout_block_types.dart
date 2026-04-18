import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/views/components/big_grid_item.dart';
import 'package:app/feed/views/components/big_grid_picture_item.dart';
import 'package:app/feed/views/components/headline.dart';
import 'package:app/feed/views/components/headline_picture.dart';
import 'package:app/feed/views/components/search_result.dart';
import 'package:app/feed/views/components/small_grid_item.dart';
import 'package:app/feed/views/components/top_stories.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/models/layout_block_settings.dart';
import 'package:app/layouts/views/components/previews/big_grid_big.dart';
import 'package:app/layouts/views/components/previews/big_grid_picture_big.dart';
import 'package:app/layouts/views/components/previews/big_grid_picture_small.dart';
import 'package:app/layouts/views/components/previews/big_grid_small.dart';
import 'package:app/layouts/views/components/previews/headline_big.dart';
import 'package:app/layouts/views/components/previews/headline_picture_big.dart';
import 'package:app/layouts/views/components/previews/headline_picture_small.dart';
import 'package:app/layouts/views/components/previews/headline_small.dart';
import 'package:app/layouts/views/components/previews/search_result_big.dart';
import 'package:app/layouts/views/components/previews/search_result_small.dart';
import 'package:app/layouts/views/components/previews/small_grid_big.dart';
import 'package:app/layouts/views/components/previews/small_grid_small.dart';
import 'package:app/layouts/views/components/previews/top_stories_big.dart';
import 'package:app/layouts/views/components/previews/top_stories_small.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:flutter/material.dart';

const double smallPreviewSize = 150;

enum LayoutBlockTypes {
  bigHeadline(1, HeadlineSmall(), LayoutBlockSettings()),
  topStories(4, TopStoriesSmall(), LayoutBlockSettings(title: 'Top stories')),
  bigGrid(null, BigGridSmall(), LayoutBlockSettings(items: 6)),
  smallGrid(null, SmallGridSmall(), LayoutBlockSettings(items: 10)),
  bigHeadlinePicture(1, HeadlinePictureSmall(), LayoutBlockSettings()),
  bigGridPicture(null, BigGridPictureSmall(), LayoutBlockSettings(items: 6)),
  searchResult(null, SearchResultSmall(), LayoutBlockSettings(items: 6));

  final int? fixedItemSize;
  final Widget smallPreview;
  final LayoutBlockSettings defaultSettings;

  const LayoutBlockTypes(this.fixedItemSize, this.smallPreview, this.defaultSettings);

  bool get fixedSize => fixedItemSize != null;

  String getLabel(AppLocalizations locals) {
    return switch (this) {
      bigHeadline => locals.headline,
      topStories => locals.topStories,
      bigGrid => locals.bigGrid,
      smallGrid => locals.smallGrid,
      bigHeadlinePicture => locals.headlinePicture,
      bigGridPicture => locals.bigGridPicture,
      searchResult => locals.singleItemRow,
    };
  }

  Widget getBigPreview(
    BuildContext context, {
    required LayoutBlock block,
    required Function(LayoutBlock block) onUpdated,
    required bool last,
    required List<FeedCategory> categories,
  }) {
    return switch (this) {
      bigGrid => BigGridBig(block: block, onUpdated: onUpdated, last: last, categories: categories),
      topStories => TopStoriesBig(block: block, onUpdated: onUpdated, categories: categories),
      smallGrid => SmallGridBig(block: block, onUpdated: onUpdated, last: last, categories: categories),
      bigHeadline => HeadlineBig(block: block, onUpdated: onUpdated, categories: categories),
      bigHeadlinePicture => HeadlinePictureBig(block: block, onUpdated: onUpdated, categories: categories),
      searchResult => SearchResultBig(block: block, onUpdated: onUpdated, last: last, categories: categories),
      bigGridPicture => BigGridPictureBig(block: block, onUpdated: onUpdated, last: last, categories: categories),
    };
  }

  Widget getSliver({required BuildContext context, required List<FeedItem> items, required LayoutBlock block}) {
    final breakPoint = BreakPoint.get(context);
    return switch (this) {
      bigHeadline =>
        breakPoint == .mobile
            ? _bigGridSliver(breakPoint: breakPoint, items: items, block: block)
            : SliverToBoxAdapter(child: Headline(item: items.first)),
      bigHeadlinePicture =>
        breakPoint == .mobile
            ? _bigGridPictureSliver(breakPoint: breakPoint, items: items, block: block)
            : SliverToBoxAdapter(child: HeadlinePicture(item: items.first)),
      topStories =>
        breakPoint == .mobile
            ? _bigGridSliver(items: items, block: block, breakPoint: breakPoint)
            : SliverToBoxAdapter(
                child: TopStories(items: items, block: block),
              ),
      bigGrid => _bigGridSliver(breakPoint: breakPoint, items: items, block: block),
      searchResult => SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => SearchResult(item: items[index], fullDate: false),
      ),
      bigGridPicture => _bigGridPictureSliver(breakPoint: breakPoint, items: items, block: block),
      smallGrid => SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: switch (breakPoint) {
            .mobile => 1,
            _ => 2,
          },
          mainAxisExtent: 150,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SmallGridItem(key: ValueKey(items[index]), item: items[index]);
        },
      ),
    };
  }

  Widget _bigGridSliver({required BreakPoint breakPoint, required List<FeedItem> items, required LayoutBlock block}) {
    return SliverGrid.builder(
      key: Key(items.firstOrNull?.id ?? ''),
      itemCount: items.length,
      itemBuilder: (context, index) => BigGridItem(key: ValueKey(items[index]), item: items[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: switch (breakPoint) {
          .mobile => 1,
          .tablet => 2,
          _ => 3,
        },
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 450,
      ),
    );
  }

  Widget _bigGridPictureSliver({
    required BreakPoint breakPoint,
    required List<FeedItem> items,
    required LayoutBlock block,
  }) {
    return SliverGrid.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => BigGridPictureItem(key: ValueKey(items[index]), item: items[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: switch (breakPoint) {
          .mobile => 1,
          .tablet => 2,
          _ => 3,
        },
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 450,
      ),
    );
  }
}
