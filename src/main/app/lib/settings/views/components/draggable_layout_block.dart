import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/settings/views/components/dragged_layout_block.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';

class DraggableLayoutBlock extends StatelessWidget {
  final Function(bool dragging) setDragging;
  final LayoutBlockTypes type;

  const DraggableLayoutBlock({super.key, required this.setDragging, required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    return Draggable<LayoutBlockTypes>(
      onDragStarted: () => setDragging(true),
      onDragEnd: (details) => setDragging(false),
      hitTestBehavior: HitTestBehavior.translucent,
      feedback: DraggedLayoutBlock(type: type),
      data: type,
      child: Column(
        spacing: pu,
        children: [
          Gap(pu2),
          Text(type.getLabel(locals), style: TextStyle(color: colors.primary)),
          type.smallPreview,
        ],
      ),
    );
  }
}
