import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

import 'package:app/layouts/views/components/previews/preview_container.dart';

class BigGridPictureSmall extends StatelessWidget {
  const BigGridPictureSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallPreviewSize,
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 16 / 14,
        children: [_GridItem(), _GridItem(), _GridItem(), _GridItem(), _GridItem(), _GridItem()],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return PreviewContainer(
      borderRadius: .circular(5),
      child: Padding(
        padding: EdgeInsets.all(pu),
        child: Column(
          mainAxisAlignment: .end,
          spacing: pu / 2,
          children: [
            PreviewContainer(color: colors.surface, height: 5, borderRadius: .circular(5)),
            PreviewContainer(color: colors.surface, height: 2, borderRadius: .circular(5)),
            PreviewContainer(color: colors.surface, height: 2, borderRadius: .circular(5)),
          ],
        ),
      ),
    );
  }
}
