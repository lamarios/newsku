import 'package:app/feed/models/feed_category.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class LayoutCategorySelector extends StatelessWidget {
  final LayoutBlock block;
  final List<FeedCategory> categories;
  final Function(LayoutBlock block) onUpdated;

  const LayoutCategorySelector({super.key, required this.block, required this.onUpdated, required this.categories});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return Padding(
      padding: .only(top: pu4),
      child: Row(
        mainAxisSize: .max,
        spacing: pu4,
        children: [
          Tooltip(message: locals.layoutBlockCategoryExplanation, child: Text(locals.feedCategory)),
          Expanded(
            child: DropdownMenu<FeedCategory>(
              initialSelection: categories.where((element) => element.id == block.settings?.categoryId).firstOrNull,
              onSelected: (value) {
                var settings = block.settings ?? block.type.defaultSettings;
                onUpdated(block.copyWith(settings: settings.copyWith(categoryId: value?.id)));
              },
              dropdownMenuEntries: categories
                  .map((h) => DropdownMenuEntry(value: h, label: h.id != null ? h.name : locals.any))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
