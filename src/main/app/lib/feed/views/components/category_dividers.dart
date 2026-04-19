import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/views/components/category_pill.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

const double _dividerHeight = 3;

class CategoryStartDivider extends StatelessWidget {
  final FeedCategory category;

  const CategoryStartDivider({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: .only(bottom: pu2),
      child: Row(
        children: [
          CategoryPill(category: category),
          Expanded(
            child: Container(
              height: _dividerHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [colors.tertiary, Colors.transparent], stops: [0.0, 0.75]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryEndDivider extends StatelessWidget {
  final FeedCategory category;

  const CategoryEndDivider({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: .only(top: pu8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: _dividerHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.transparent, colors.tertiary], stops: [0.25, 1]),
              ),
            ),
          ),
          // CategoryPill(category: category),
        ],
      ),
    );
  }
}
