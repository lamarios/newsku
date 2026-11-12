import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class HeadlineSmall extends StatelessWidget {
  const HeadlineSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallPreviewSize,
      child: Column(
        spacing: pu,
        children: [
          PreviewContainer(width: smallPreviewSize, height: smallPreviewSize / 3, borderRadius: .circular(5)),

          PreviewContainer(width: smallPreviewSize, height: 10, borderRadius: .circular(20)),
          PreviewContainer(width: smallPreviewSize, height: 2, borderRadius: .circular(20)),
          PreviewContainer(width: smallPreviewSize, height: 2, borderRadius: .circular(20)),
          PreviewContainer(width: smallPreviewSize, height: 2, borderRadius: .circular(20)),
        ],
      ),
    );
  }
}
