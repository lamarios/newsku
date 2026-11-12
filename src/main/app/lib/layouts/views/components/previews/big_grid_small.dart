import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

import 'package:app/layouts/views/components/previews/preview_container.dart';

class BigGridSmall extends StatelessWidget {
  const BigGridSmall({super.key});

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
    return Column(
      spacing: pu,
      children: [
        PreviewContainer(height: 20, borderRadius: .circular(5)),
        PreviewContainer(height: 5, borderRadius: .circular(5)),
        PreviewContainer(height: 2, borderRadius: .circular(5)),
        PreviewContainer(height: 2, borderRadius: .circular(5)),
      ],
    );
  }
}
