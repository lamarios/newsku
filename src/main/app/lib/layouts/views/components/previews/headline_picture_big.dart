import 'package:app/feed/models/feed_category.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/views/components/layout_category_selector.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class HeadlinePictureBig extends StatelessWidget {
  final LayoutBlock block;
  final Function(LayoutBlock block) onUpdated;
  final List<FeedCategory> categories;

  const HeadlinePictureBig({super.key, required this.block, required this.onUpdated, required this.categories});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        PreviewContainer(
          height: 150,
          borderRadius: .circular(5),
          child: Padding(
            padding: EdgeInsets.all(pu2),
            child: Column(
              mainAxisAlignment: .end,
              spacing: pu,
              children: [
                PreviewContainer(height: 15, borderRadius: .circular(10), color: colors.surface),
                PreviewContainer(height: 15, borderRadius: .circular(10), color: colors.surface),
              ],
            ),
          ),
        ),
        LayoutCategorySelector(block: block, onUpdated: onUpdated, categories: categories),
      ],
    );
  }
}
