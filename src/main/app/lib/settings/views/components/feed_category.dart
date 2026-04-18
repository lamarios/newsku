import 'dart:math' as math;

import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/settings/states/feeds.dart';
import 'package:app/settings/views/components/dragged_feed.dart';
import 'package:app/utils/dialog.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/states/simple_cubit.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/simple_cubit_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:motor/motor.dart';

class FeedCategoryView extends StatelessWidget {
  final FeedCategory category;
  final List<Feed> feeds;

  const FeedCategoryView({super.key, required this.category, required this.feeds});

  Future<void> renameCategory(BuildContext context) async {
    final locals = AppLocalizations.of(context)!;
    String? newName = await showTextInputDialog(context, locals.rename, initialValue: category.name);
    if (context.mounted && newName != null) {
      context.read<FeedsSettingsCubit>().updateCategory(category.copyWith(name: newName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    var cubit = context.read<FeedsSettingsCubit>();

    return DragTarget<Feed>(
      onAcceptWithDetails: (details) => cubit.setFeedCategory(category, details),
      builder: (context, List<Feed?> candidates, List<dynamic> rejected) {
        return SingleMotionBuilder(
          from: 0,
          value: candidates.isNotEmpty && candidates.first?.category?.id != category.id ? 1 : 0,
          motion: MaterialSpringMotion.expressiveSpatialDefault(),
          builder: (context, value, child) => Container(
            padding: EdgeInsets.all(pu2),
            margin: .only(bottom: pu8, left: pu, right: pu),
            decoration: BoxDecoration(
              borderRadius: .circular(pu3),
              border: Border.all(color: Color.lerp(colors.surface, colors.primary, value) ?? colors.surface),
            ),
            child: child,
          ),
          child: SimpleCubitView<bool>(
            initialValue: true,
            builder: (context, expanded) {
              final simpleCubit = context.read<SimpleCubit<bool>>();
              return Column(
                crossAxisAlignment: .stretch,
                children: [
                  Gap(pu2),
                  InkWell(
                    onTap: () => simpleCubit.setValue(!expanded),
                    child: Row(
                      spacing: pu2,
                      children: [
                        SingleMotionBuilder(
                          value: expanded ? 0 : math.pi,
                          from: 0,
                          motion: MaterialSpringMotion.expressiveEffectsSlow(),
                          builder: (BuildContext context, double value, Widget? child) =>
                              Transform.rotate(angle: value, child: child),
                          child: Icon(Icons.expand_less),
                        ),
                        Expanded(
                          child: Text(
                            category.id == null ? locals.uncategorized : category.name,
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (expanded) ...[
                    if (category.id != null)
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () => renameCategory(context),
                            label: Text(locals.rename),
                            icon: Icon(Icons.edit),
                          ),
                          TextButton.icon(
                            onPressed: () => okCancelDialog(
                              context,
                              title: locals.delete,
                              content: Text(locals.deleteCategoryExplanation),
                              onOk: () => cubit.deleteCategory(category),
                            ),
                            label: Text(locals.delete),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    Gap(8),
                    if (feeds.isNotEmpty)
                      ...feeds.map((f) {
                        return ListTile(
                          leading: Draggable<Feed>(
                            feedback: DraggedFeed(feed: f),
                            data: f,
                            child: Icon(Icons.drag_handle),
                          ),
                          title: Row(
                            spacing: pu,
                            children: [
                              ClipRRect(
                                borderRadius: .circular(20),
                                child: FeedImage(item: f, width: 20, height: 20),
                              ),
                              Expanded(child: Text(f.name ?? '')),
                            ],
                          ),
                          subtitle: SelectableText(f.url ?? ''),
                          trailing: Row(
                            mainAxisAlignment: .end,
                            crossAxisAlignment: .center,
                            mainAxisSize: .min,
                            children: [
                              _ErrorButton(feed: f),
                              IconButton(
                                onPressed: () {
                                  okCancelDialog(
                                    context,
                                    title: locals.deleteFeed,
                                    content: Text(locals.deleteFeedMessage),
                                    onOk: () => cubit.deleteFeed(f),
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      })
                    else
                      Text(locals.noFeedInCategory, style: textTheme.labelSmall),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ErrorButton extends StatelessWidget {
  final Feed feed;

  const _ErrorButton({required this.feed});

  void openErrors(BuildContext context) {
    AutoRouter.of(context).push(FeedErrorsRoute(feed: feed));
  }

  @override
  Widget build(BuildContext context) {
    final device = BreakPoint.get(context);
    final colors = Theme.of(context).colorScheme;

    final locals = AppLocalizations.of(context)!;
    final hasErrors = feed.lastRefreshErrors > 0;
    var icon = Icon(
      hasErrors ? Icons.error_outline : Icons.check,
      color: hasErrors ? colors.error : Colors.lightGreen.withValues(alpha: 0.5),
    );
    return Tooltip(
      message: locals.duringLastRefreshAttempt,
      child: device == .mobile
          ? IconButton(onPressed: () => openErrors(context), icon: icon)
          : TextButton.icon(
              onPressed: () => openErrors(context),
              icon: icon,
              label: Text(
                locals.nErrors(feed.lastRefreshErrors),
                style: TextStyle(color: hasErrors ? colors.error : colors.onSurface.withValues(alpha: 0.5)),
              ),
            ),
    );
  }
}
