import 'package:app/feed/models/feed_category.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryPill extends StatelessWidget {
  final FeedCategory category;
  final String? text;

  const CategoryPill({super.key, required this.category, this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: colors.tertiary, borderRadius: .circular(50)),
      padding: .symmetric(horizontal: pu4),
      child: Text(
        text ?? category.name,
        maxLines: 1,
        overflow: .ellipsis,
        style: textTheme.bodyLarge?.copyWith(fontSize: 20, color: colors.onTertiary),
      ),
    );
  }
}
