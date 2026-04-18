import 'dart:math';
import 'dart:ui';

import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/states/main_feed.dart';
import 'package:app/feed/views/components/date_bar.dart';
import 'package:app/feed/views/components/search_result.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:app/user/views/components/fancy_side.dart';
import 'package:app/user/views/components/user_profile_picture.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/app_logo.dart';
import 'package:app/utils/views/components/app_name.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:app/utils/views/components/main_color_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:material_loading_indicator/loading_indicator.dart';
import 'package:motor/motor.dart';

final articleDateFormat = DateFormat.Hm();
final fullArticleDateFormat = DateFormat.yMMMd().add_Hm();
final double feedItemBorderRadius = 8;

final _log = Logger('FeedScreen');

@RoutePage()
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  List<Widget> buildSlivers({
    required BuildContext context,
    required DateTimeRange<DateTime> timeRange,
    required List<FeedItem> immutableItems,
    required List<LayoutBlock> blocks,
    required int readItems,
    required double padding,
  }) {
    final locals = AppLocalizations.of(context)!;

    List<Widget> slivers = [];
    _log.fine(
      'Building Slivers, TimeRange: $timeRange, Layout blocks: ${blocks.length}, Items: ${immutableItems.length}',
    );

    List<FeedItem> items = List.from(immutableItems);

    // for each block, we try to fit items
    for (final (index, block) in blocks.indexed) {
      if (items.isEmpty) {
        break;
      }

      List<FeedItem> blockItems = [];
      if (index == blocks.length - 1) {
        // if we're in the last block, we take all items
        blockItems = List.from(items);
      } else {
        int blockSize = block.type.fixedItemSize ?? block.settings?.items ?? 0;
        _log.fine('${block.type}: Block Size: $blockSize');
        // we take the items the block is expecting
        var list = items
            .where((i) => block.settings?.categoryId == null || i.feed?.category?.id == block.settings?.categoryId)
            .take(blockSize)
            .toList();

        blockItems.addAll(list);
      }
      _log.fine('Block item: ${blockItems.length}');

      if (blockItems.isNotEmpty) {
        _log.fine('Adding block ${block.type} with ${blockItems.length} items');
        slivers.add(block.type.getSliver(context: context, items: blockItems, block: block));
      }

      // we remove them from the main list
      for (var element in blockItems) {
        items.remove(element);
      }
    }

    for (int i = 0; i < slivers.length; i++) {
      slivers[i] = SliverPadding(
        padding: .symmetric(horizontal: padding + pu4),
        sliver: SliverStickyHeader.builder(
          builder: (context, state) => DateBar(date: timeRange.end, isPinned: state.isPinned, isFirst: i == 0),

          sliver: slivers[i],
        ),
      );
    }

    if (readItems > 0) {
      final colors = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      slivers.add(
        SliverPadding(
          padding: .only(top: pu4),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: .center,
              spacing: pu2,
              children: [
                Icon(Icons.task_alt, color: colors.secondary, size: 15),
                Text(locals.readItems(readItems), style: textTheme.bodySmall?.copyWith(color: colors.secondary)),
              ],
            ),
          ),
        ),
      );
    }

    return slivers;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    return MainColorProvider(
      builder: (context, appColor) {
        return BlocProvider(
          create: (context) => MainFeedCubit(
            MainFeedState(currentTime: DateTime.now().copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)),
          ),
          child: ErrorHandler<MainFeedCubit, MainFeedState>(
            child: BlocBuilder<MainFeedCubit, MainFeedState>(
              builder: (context, state) {
                var cubit = context.read<MainFeedCubit>();
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final double padding = max(0, (constraints.maxWidth - BreakPoint.desktop.maxWidth) / 2);

                    return Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: .symmetric(horizontal: 0),
                                    child: RefreshIndicator(
                                      onRefresh: () => cubit.refresh(),
                                      child: CustomScrollView(
                                        key: Key('scrollable-feed'),
                                        controller: cubit.scrollController,
                                        slivers: [
                                          SliverAppBar(
                                            key: Key('app-bar'),
                                            floating: true,
                                            snap: true,
                                            elevation: 0,
                                            scrolledUnderElevation: 0,
                                            leadingWidth: 150,
                                            title: AnimatedSwitcher(
                                              duration: Duration(milliseconds: 250),
                                              child: state.searchMode
                                                  ? TextField(
                                                      controller: cubit.searchController,
                                                      autofocus: true,
                                                      onChanged: (value) => cubit.search(value),
                                                      decoration: InputDecoration(
                                                        border: UnderlineInputBorder(),
                                                        label: Text(locals.search),
                                                      ),
                                                    )
                                                  : AppName(style: textTheme.titleLarge),
                                            ),
                                            leading: state.searchMode
                                                ? null
                                                : ClipPath(
                                                    clipper: FancySide(),
                                                    child: Container(
                                                      decoration: BoxDecoration(color: appColor),
                                                      child: Padding(
                                                        padding: .only(left: pu6),
                                                        child: Align(
                                                          alignment: .centerLeft,
                                                          child: AppLogo(color: colors.onSurface, size: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            actions: [
                                              IconButton(
                                                onPressed: () => cubit.setSearch(!state.searchMode),
                                                icon: Icon(state.searchMode ? Icons.close : Icons.search),
                                              ),
                                              if (!state.searchMode) ...[
                                                IconButton(onPressed: () => cubit.refresh(), icon: Icon(Icons.refresh)),
                                              ],
                                              MenuAnchor(
                                                key: Key('profile-button'),
                                                builder: (context, controller, child) => IconButton(
                                                  onPressed: () =>
                                                      controller.isOpen ? controller.close() : controller.open(),
                                                  icon: UserProfilePicture(),
                                                ),
                                                menuChildren: [
                                                  MenuItemButton(
                                                    leadingIcon: Icon(Icons.show_chart),
                                                    onPressed: () => AutoRouter.of(context).push(StatsRoute()),
                                                    child: Text(locals.stats),
                                                  ),
                                                  if (!(context.read<IdentityCubit>().state.config?.demoMode ?? false))
                                                    MenuItemButton(
                                                      key: Key('settings-button'),
                                                      leadingIcon: ConditionalWrap(
                                                        wrapIf: state.errorCount > 0,
                                                        wrapper: (child) => Badge(
                                                          offset: Offset(5, 0),
                                                          backgroundColor: colors.errorContainer,
                                                          textColor: colors.error,
                                                          label: Text('${state.errorCount}'),
                                                          child: child,
                                                        ),

                                                        child: Icon(Icons.settings),
                                                      ),
                                                      child: Text(locals.settings),
                                                      onPressed: () => AutoRouter.of(
                                                        context,
                                                      ).push(SettingsRoute()).then((value) => cubit.refresh()),
                                                    ),
                                                  Divider(),
                                                  MenuItemButton(
                                                    leadingIcon: Icon(Icons.logout),
                                                    onPressed: () => getIt.get<IdentityCubit>().logout(),
                                                    child: Text(locals.logout),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (state.searchMode)
                                            SliverPadding(
                                              padding: .symmetric(horizontal: padding),
                                              sliver: SliverList.builder(
                                                itemCount: state.searchResults.length,
                                                itemBuilder: (context, index) {
                                                  return SearchResult(
                                                    key: ValueKey(state.searchResults[index]),
                                                    item: state.searchResults[index],
                                                    fullDate: true,
                                                    noDimming: true,
                                                  );
                                                },
                                              ),
                                            )
                                          else
                                            ...state.items.keys.expand((value) {
                                              var feed = state.items[value] ?? [];
                                              final totalItemCount = feed.length;
                                              // if the user wants ti hide read item, we do so

                                              var unreadCount = totalItemCount;
                                              if (context.read<IdentityCubit>().currentUser?.readItemHandling ==
                                                  .hide) {
                                                feed = feed.where((element) => !element.read).toList();
                                                unreadCount = feed.length;
                                              }

                                              if (feed.isNotEmpty) {
                                                return buildSlivers(
                                                  context: context,
                                                  timeRange: value,
                                                  immutableItems: feed,
                                                  blocks: state.layout,
                                                  readItems: totalItemCount - unreadCount,
                                                  padding: padding,
                                                );
                                              } else {
                                                return [
                                                  SliverPadding(
                                                    padding: .symmetric(vertical: padding),
                                                    sliver: SliverStickyHeader.builder(
                                                      builder: (context, state) => DateBar(
                                                        date: value.end,
                                                        isPinned: state.isPinned,
                                                        isFirst: true,
                                                      ),
                                                      sliver: SliverToBoxAdapter(
                                                        child: SizedBox(
                                                          height: 500,
                                                          child: Column(
                                                            mainAxisAlignment: .center,
                                                            spacing: pu6,
                                                            children: [
                                                              Icon(
                                                                unreadCount == 0 && totalItemCount > 0
                                                                    ? Icons.task_alt_outlined
                                                                    : Icons.newspaper,
                                                                size: 50,
                                                                color: colors.onSurface,
                                                              ),
                                                              if (totalItemCount == 0)
                                                                Text(locals.noNews, style: textTheme.titleLarge),
                                                              // this is our read item count
                                                              if (unreadCount == 0 && totalItemCount > 0)
                                                                Text(
                                                                  locals.readItems(totalItemCount - unreadCount),
                                                                  style: textTheme.titleLarge,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              }
                                            }),
                                          if (state.loading)
                                            SliverToBoxAdapter(
                                              child: Center(
                                                child: SizedBox(width: 50, height: 50, child: LoadingIndicator()),
                                              ),
                                            )
                                          else if (!state.searchMode ||
                                              (state.searchMode &&
                                                  state.searchResults.length ==
                                                      searchPageSize * (state.searchPage + 1)))
                                            SliverToBoxAdapter(
                                              child: Center(
                                                child: FilledButton.tonalIcon(
                                                  onPressed: () => state.searchMode
                                                      ? cubit.loadMoreSearchResults()
                                                      : cubit.getFeed(),
                                                  label: Text(locals.loadMore),
                                                  icon: Icon(Icons.expand_more),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleMotionBuilder(
                            motion: MaterialSpringMotion.expressiveSpatialDefault(),
                            from: 0,
                            value: state.hasScrolled ? 1 : 0,
                            builder: (context, value, child) => Positioned(
                              right: 30,
                              bottom: lerpDouble(-100, 30, value),
                              child: Opacity(opacity: value.clamp(0, 1), child: child!),
                            ),
                            child: FloatingActionButton(
                              onPressed: () => cubit.scrollController.animateTo(
                                0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOutQuart,
                              ),
                              child: Icon(Icons.arrow_upward),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
