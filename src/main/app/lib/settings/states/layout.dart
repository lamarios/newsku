import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/services/feed_service.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/models/layout_block_types.dart';
import 'package:app/layouts/services/layout.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout.freezed.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final scrollController = ScrollController();

  LayoutCubit(super.initialState) {
    init();
  }

  Future<void> init() async {
    await getLayout();
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  void setDragging(bool dragging) {
    emit(state.copyWith(dragging: dragging));
  }

  Future<void> getLayout() async {
    try {
      emit(state.copyWith(loading: true));
      var layout = LayoutService(serverUrl!).getLayout();
      var categories = await FeedService(serverUrl!).getFeedCategories();
      categories.insert(0, FeedCategory(name: "Any"));
      emit(state.copyWith(blocks: await layout, categories: categories, loading: false));
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
      rethrow;
    }
  }

  void acceptDrag(int index, DragTargetDetails<LayoutBlockTypes> details) {
    final blocks = List<LayoutBlock>.from(state.blocks);

    LayoutBlock newBlock = LayoutBlock(type: details.data, order: index + 1, settings: details.data.defaultSettings);

    blocks.insert(index + 1, newBlock);

    for (int i = 0; i < blocks.length; i++) {
      blocks[i] = blocks[i].copyWith(order: i);
    }

    emit(state.copyWith(dragging: false, blocks: blocks));
  }

  void removeBlock(LayoutBlock block) {
    final blocks = List<LayoutBlock>.from(state.blocks);
    blocks.remove(block);
    emit(state.copyWith(blocks: blocks));
  }

  Future<void> save() async {
    try {
      if (state.valid) {
        await LayoutService(serverUrl!).setLayout(state.blocks);
      }
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
      rethrow;
    }
  }

  void updateBlock(LayoutBlock oldBlock, LayoutBlock newBlock) {
    final blocks = List<LayoutBlock>.from(state.blocks);

    final index = blocks.indexOf(oldBlock);

    blocks[index] = newBlock;

    emit(state.copyWith(blocks: blocks));
  }

  void onReorder(int oldIndex, int newIndex) {
    final blocks = List<LayoutBlock>.from(state.blocks);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, item);

    for (int i = 0; i < blocks.length; i++) {
      blocks[i] = blocks[i].copyWith(order: i);
    }

    emit(state.copyWith(blocks: blocks));
  }
}

@freezed
sealed class LayoutState with _$LayoutState implements WithError {
  @Implements<WithError>()
  const factory LayoutState({
    @Default(false) bool dragging,
    @Default([]) List<LayoutBlock> blocks,
    @Default([]) List<FeedCategory> categories,
    @Default(true) bool loading,
    dynamic error,
    StackTrace? stackTrace,
  }) = _LayoutState;

  const LayoutState._();

  bool get valid => blocks.isNotEmpty && !blocks.last.type.fixedSize;
}
