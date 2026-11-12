import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class DraggedLayoutBlock extends StatelessWidget {
  final LayoutBlockTypes type;

  const DraggedLayoutBlock({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Opacity(
      opacity: 0.75,
      child: Container(
        decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: .circular(20)),
        padding: .all(pu5),
        child: type.smallPreview,
      ),
    );
  }
}
