import 'dart:math';

import 'package:app/feed/models/feed_category.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/views/components/layout_category_selector.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchResultBig extends StatelessWidget {
  final LayoutBlock block;
  final Function(LayoutBlock block) onUpdated;
  final bool last;
  final List<FeedCategory> categories;

  const SearchResultBig({
    super.key,
    required this.block,
    required this.onUpdated,
    required this.last,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            last ? 3 : (block.settings ?? block.type.defaultSettings).items ?? 0,
            (index) => _GridItem(),
          ),
        ),
        if (!last) ...[
          Row(
            mainAxisAlignment: .center,
            children: [
              IconButton(
                onPressed: () {
                  var settings = block.settings ?? block.type.defaultSettings;
                  onUpdated(block.copyWith(settings: settings.copyWith(items: max(1, (settings.items ?? 0) - 1))));
                },
                icon: Icon(Icons.remove),
              ),
              Text(locals.nItems((block.settings ?? block.type.defaultSettings).items ?? 0)),
              IconButton(
                onPressed: () {
                  var settings = block.settings ?? block.type.defaultSettings;
                  onUpdated(block.copyWith(settings: settings.copyWith(items: (settings.items ?? 0) + 1)));
                },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
          LayoutCategorySelector(block: block, onUpdated: onUpdated, categories: categories),
        ],
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(bottom: pu2),
      child: Row(
        spacing: pu2,
        children: [
          PreviewContainer(width: 50, height: 50, borderRadius: .circular(10)),
          Expanded(
            child: Column(
              spacing: pu,
              children: [
                PreviewContainer(height: 10, borderRadius: .circular(10)),
                PreviewContainer(height: 5, borderRadius: .circular(5)),
                PreviewContainer(height: 5, borderRadius: .circular(5)),
                PreviewContainer(height: 5, borderRadius: .circular(5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
