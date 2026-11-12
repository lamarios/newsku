import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/layouts/views/components/previews/preview_container.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class HeadlinePictureSmall extends StatelessWidget {
  const HeadlinePictureSmall({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: smallPreviewSize,
      child: PreviewContainer(
        height: 80,
        borderRadius: .circular(5),
        child: Padding(
          padding: EdgeInsets.all(pu2),
          child: Column(
            mainAxisAlignment: .end,
            spacing: pu,
            children: [
              PreviewContainer(height: 10, borderRadius: .circular(10), color: colors.surface),
              PreviewContainer(height: 10, borderRadius: .circular(10), color: colors.surface),
            ],
          ),
        ),
      ),
    );
  }
}
