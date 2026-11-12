import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class TopStoriesSmall extends StatelessWidget {
  const TopStoriesSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallPreviewSize,
      child: Row(
        crossAxisAlignment: .start,
        spacing: pu,
        children: [
          Expanded(
            child: Column(spacing: pu, children: [_LeftArticle(), _LeftArticle(), _LeftArticle()]),
          ),
          Expanded(
            child: Column(
              spacing: pu,
              children: [
                PreviewContainer(height: 40, borderRadius: .circular(5)),
                PreviewContainer(width: smallPreviewSize, height: 10, borderRadius: .circular(20)),
                PreviewContainer(width: smallPreviewSize, height: 2, borderRadius: .circular(20)),
                PreviewContainer(width: smallPreviewSize, height: 2, borderRadius: .circular(20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftArticle extends StatelessWidget {
  const _LeftArticle();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: pu,
      children: [
        PreviewContainer(width: 20, height: 20, borderRadius: .circular(20)),
        Expanded(
          child: Column(
            spacing: pu,
            children: [
              PreviewContainer(height: 5, borderRadius: .circular(10)),
              PreviewContainer(height: 5, borderRadius: .circular(10)),
            ],
          ),
        ),
      ],
    );
  }
}
