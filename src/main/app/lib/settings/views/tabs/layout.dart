import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/settings/states/layout.dart';
import 'package:app/settings/views/components/draggable_layout_block.dart';
import 'package:app/settings/views/components/dragged_layout_block.dart';
import 'package:app/settings/views/components/layout_separator.dart';
import 'package:app/settings/views/components/new_block_dialog.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/states/simple_cubit.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:app/utils/views/components/simple_cubit_view.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class LayoutSettingsTab extends StatelessWidget {
  final Color? fadeColor;

  const LayoutSettingsTab({super.key, this.fadeColor});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;

    final device = BreakPoint.get(context);

    return Padding(
      padding: .only(bottom: pu8, left: pu2, right: pu2, top: pu2),
      child: BlocProvider(
        create: (context) => LayoutCubit(LayoutState()),
        child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) => context.read<LayoutCubit>().save(),
          listenWhen: (previous, current) => current.blocks.isNotEmpty && previous.blocks != current.blocks,
          builder: (context, state) {
            final cubit = context.read<LayoutCubit>();
            return ErrorHandler<LayoutCubit, LayoutState>(
              child: Column(
                children: [
                  Expanded(
                    child: Flex(
                      direction: device == .mobile ? .vertical : .horizontal,
                      spacing: pu2,
                      children: [
                        if (device == .mobile)
                          SimpleCubitView<bool>(
                            initialValue: false,
                            builder: (context, expanded) => Row(
                              crossAxisAlignment: .start,
                              children: [
                                Expanded(
                                  child: Text(
                                    locals.layoutExplanation,
                                    overflow: .ellipsis,
                                    maxLines: expanded ? 10 : 2,
                                  ),
                                ),
                                IconButton(
                                  visualDensity: .compact,
                                  onPressed: () => context.read<SimpleCubit<bool>>().setValue(!expanded),
                                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                                ),
                              ],
                            ),
                          ),
                        if (device != .mobile)
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Gap(pu2),
                                Text(locals.layoutExplanation),
                                Divider(),
                                Text(locals.availableBlocks, style: textTheme.titleLarge),
                                Text(locals.dragAndDropInstructions),
                                Gap(pu8),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      Text(locals.fixedArticleCountBlocks),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.bigHeadline,
                                        ),
                                      ),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.bigHeadlinePicture,
                                        ),
                                      ),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.topStories,
                                        ),
                                      ),
                                      Gap(pu8),
                                      Text(locals.dynamicArticleCountBlocks),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.bigGrid,
                                        ),
                                      ),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.bigGridPicture,
                                        ),
                                      ),
                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.smallGrid,
                                        ),
                                      ),

                                      Center(
                                        child: DraggableLayoutBlock(
                                          setDragging: cubit.setDragging,
                                          type: LayoutBlockTypes.searchResult,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        VerticalDivider(),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: .stretch,
                            children: [
                              Gap(pu2),
                              Row(
                                children: [
                                  Expanded(child: Text(locals.currentLayout, style: textTheme.titleLarge)),
                                  if (device == .mobile)
                                    TextButton(
                                      onPressed: () async {
                                        final newBlock = await NewBlockDialog.show(context);
                                        if (newBlock != null) {
                                          cubit.acceptDrag(
                                            state.blocks.length - 1,
                                            DragTargetDetails(data: newBlock, offset: .zero),
                                          );
                                          cubit.scrollController.animateTo(
                                            cubit.scrollController.position.maxScrollExtent +
                                                cubit.scrollController.position.viewportDimension,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeInOutQuart,
                                          );
                                        }
                                      },
                                      child: Text(locals.addBlock),
                                    ),
                                ],
                              ),
                              Expanded(
                                child: ReorderableListView.builder(
                                  scrollController: cubit.scrollController,
                                  proxyDecorator: (child, index, animation) =>
                                      Center(child: DraggedLayoutBlock(type: state.blocks[index].type)),
                                  itemCount: state.blocks.length,
                                  onReorder: (int oldIndex, int newIndex) => cubit.onReorder(oldIndex, newIndex),

                                  buildDefaultDragHandles: false,
                                  itemBuilder: (context, index) {
                                    var block = state.blocks[index];

                                    var isLast = index == state.blocks.length - 1;
                                    return Padding(
                                      key: ValueKey(block),
                                      padding: .only(bottom: pu2),
                                      child: ConditionalWrap(
                                        wrapIf: index == 0,
                                        wrapper: (child) => Column(
                                          crossAxisAlignment: .stretch,
                                          children: [
                                            LayoutSeparator(index: -1, dragging: state.dragging),
                                            child,
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: .stretch,
                                          children: [
                                            Row(
                                              spacing: pu4,
                                              children: [
                                                ReorderableDragStartListener(
                                                  index: index,
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.move,
                                                    child: Icon(Icons.drag_handle, size: 40),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ConditionalWrap(
                                                    wrapIf: isLast && !block.type.fixedSize,
                                                    wrapper: (child) => Stack(
                                                      children: [
                                                        child,
                                                        Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0,
                                                          child: Container(
                                                            height: 150,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  (fadeColor ?? colors.surface).withValues(alpha: 0),
                                                                  (fadeColor ?? colors.surface),
                                                                ],
                                                                stops: [0, 0.90],
                                                                begin: .topCenter,
                                                                end: .bottomCenter,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: block.type.getBigPreview(
                                                      context,
                                                      block: block,
                                                      onUpdated: (newBlock) => cubit.updateBlock(block, newBlock),
                                                      last: isLast,
                                                      categories: state.categories,
                                                    ),
                                                  ),
                                                ),
                                                if (state.blocks.length > 1)
                                                  IconButton(
                                                    onPressed: () => cubit.removeBlock(block),
                                                    icon: Icon(Icons.delete),
                                                    color: colors.error,
                                                  ),
                                              ],
                                            ),
                                            Gap(pu4),
                                            Divider(),
                                            LayoutSeparator(index: index, dragging: state.dragging),
                                            if (state.dragging) Divider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!state.valid)
                    Text(locals.layoutMustFinishWithDynamicBlock, style: TextStyle(color: colors.error)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
