import 'dart:math';

import 'package:app/feed/models/feed_category.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/views/components/layout_category_selector.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class BigGridPictureBig extends StatelessWidget {
  final bool last;
  final LayoutBlock block;
  final Function(LayoutBlock block) onUpdated;
  final List<FeedCategory> categories;

  const BigGridPictureBig({
    super.key,
    required this.last,
    required this.block,
    required this.onUpdated,
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
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 16 / (device == .mobile ? 17 : 15),
          children: List.generate(
            last ? 6 : (block.settings ?? block.type.defaultSettings).items ?? 6,
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
                  onUpdated(block.copyWith(settings: settings.copyWith(items: max(2, (settings.items ?? 6) - 1))));
                },
                icon: Icon(Icons.remove),
              ),
              Text(locals.nItems((block.settings ?? block.type.defaultSettings).items ?? 6)),
              IconButton(
                onPressed: () {
                  var settings = block.settings ?? block.type.defaultSettings;
                  onUpdated(block.copyWith(settings: settings.copyWith(items: (settings.items ?? 6) + 1)));
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
    final device = BreakPoint.get(context);
    final colors = Theme.of(context).colorScheme;

    return PreviewContainer(
      borderRadius: .circular(10),
      child: Padding(
        padding: EdgeInsets.all(pu2),
        child: Column(
          mainAxisAlignment: .end,
          spacing: pu,
          children: [
            PreviewContainer(color: colors.surface, height: device == .mobile ? 8 : 12, borderRadius: .circular(5)),
            PreviewContainer(color: colors.surface, height: device == .mobile ? 5 : 7, borderRadius: .circular(5)),
            PreviewContainer(color: colors.surface, height: device == .mobile ? 5 : 7, borderRadius: .circular(5)),
          ],
        ),
      ),
    );
  }
}
