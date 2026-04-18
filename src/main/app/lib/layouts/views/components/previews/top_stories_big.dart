import 'package:app/feed/models/feed_category.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/views/components/layout_category_selector.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopStoriesBig extends StatefulWidget {
  final LayoutBlock block;
  final Function(LayoutBlock block) onUpdated;
  final List<FeedCategory> categories;

  const TopStoriesBig({super.key, required this.block, required this.onUpdated, required this.categories});

  @override
  State<TopStoriesBig> createState() => _TopStoriesBigState();
}

class _TopStoriesBigState extends State<TopStoriesBig> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: (widget.block.settings ?? widget.block.type.defaultSettings).title ?? '');
    controller.addListener(() {
      EasyDebounce.debounce('name-change', Duration(seconds: 1), () {
        var settings = widget.block.settings ?? widget.block.type.defaultSettings;
        widget.onUpdated(widget.block.copyWith(settings: settings.copyWith(title: controller.value.text)));
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: ValueKey(widget.block.id),
          controller: controller,
          decoration: InputDecoration(label: Text('Title')),
        ),
        Gap(pu4),
        Row(
          crossAxisAlignment: .start,
          spacing: pu3,
          children: [
            Expanded(
              child: Column(spacing: pu3, children: [_LeftArticle(), _LeftArticle(), _LeftArticle()]),
            ),
            Expanded(
              child: Column(
                spacing: pu2,
                children: [
                  PreviewContainer(height: 100, borderRadius: .circular(5)),
                  PreviewContainer(height: 20, borderRadius: .circular(20)),
                  PreviewContainer(height: 10, borderRadius: .circular(20)),
                  PreviewContainer(height: 10, borderRadius: .circular(20)),
                ],
              ),
            ),
          ],
        ),
        LayoutCategorySelector(block: widget.block, onUpdated: widget.onUpdated, categories: widget.categories),
      ],
    );
  }
}

class _LeftArticle extends StatelessWidget {
  const _LeftArticle();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: pu2,
      children: [
        PreviewContainer(width: 50, height: 50, borderRadius: .circular(50)),
        Expanded(
          child: Column(
            spacing: pu2,
            children: [
              PreviewContainer(height: 15, borderRadius: .circular(15)),
              PreviewContainer(height: 15, borderRadius: .circular(15)),
            ],
          ),
        ),
      ],
    );
  }
}
