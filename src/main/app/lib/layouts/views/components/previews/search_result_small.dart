import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class SearchResultSmall extends StatelessWidget {
  const SearchResultSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallPreviewSize,
      child: Column(spacing: pu2, children: [_Item(), _Item(), _Item()]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: pu2,
      children: [
        PreviewContainer(width: 25, height: 25, borderRadius: .circular(5)),
        Expanded(
          child: Column(
            spacing: pu,
            children: [
              PreviewContainer(height: 5, borderRadius: .circular(10)),
              PreviewContainer(height: 2, borderRadius: .circular(5)),
              PreviewContainer(height: 2, borderRadius: .circular(5)),
              PreviewContainer(height: 2, borderRadius: .circular(5)),
            ],
          ),
        ),
      ],
    );
  }
}
