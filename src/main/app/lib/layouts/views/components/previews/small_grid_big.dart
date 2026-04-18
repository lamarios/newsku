import 'dart:math';

import 'package:app/feed/models/feed_category.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/views/components/layout_category_selector.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class SmallGridBig extends StatelessWidget {
  final LayoutBlock block;
  final Function(LayoutBlock block) onUpdated;
  final bool last;
  final List<FeedCategory> categories;

  const SmallGridBig({
    super.key,
    required this.block,
    required this.onUpdated,
    required this.last,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final device = BreakPoint.get(context);

    final locals = AppLocalizations.of(context)!;
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
          childAspectRatio: 16 / (device == .mobile ? 8 : 5),
          children: List.generate(
            last ? 6 : (block.settings ?? block.type.defaultSettings).items ?? 0,
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
                  onUpdated(block.copyWith(settings: settings.copyWith(items: max(2, (settings.items ?? 0) - 1))));
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
    return Row(
      crossAxisAlignment: .center,
      spacing: pu2,
      children: [
        Expanded(
          child: Column(
            spacing: pu,
            mainAxisAlignment: .center,
            children: [
              PreviewContainer(height: 8, borderRadius: .circular(5)),
              PreviewContainer(height: 8, borderRadius: .circular(5)),
              PreviewContainer(height: 4, borderRadius: .circular(5)),
              PreviewContainer(height: 4, borderRadius: .circular(5)),
            ],
          ),
        ),
        PreviewContainer(height: 40, width: 24, borderRadius: .circular(2)),
      ],
    );
  }
}
