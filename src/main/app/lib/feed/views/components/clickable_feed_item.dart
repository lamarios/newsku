import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/services/feed_service.dart';
import 'package:app/feed/states/main_feed.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/utils/states/simple_cubit.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:app/utils/views/components/simple_cubit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ClickableFeedItem extends StatelessWidget {
  final FeedItem item;
  final Widget Function(bool hovered) builder;
  final bool noDimming;

  const ClickableFeedItem({super.key, required this.item, required this.builder, this.noDimming = false});

  @override
  Widget build(BuildContext context) {
    return SimpleCubitView<bool>(
      builder: (context, hovered) {
        var currentUser = context.read<IdentityCubit>().currentUser;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) => context.read<SimpleCubit<bool>>().setValue(true),
          onExit: (event) => context.read<SimpleCubit<bool>>().setValue(false),

          child: ConditionalWrap(
            wrapIf: item.read,
            wrapper: (child) {
              return !noDimming &&
                      (currentUser?.readItemHandling == .dim || currentUser?.readItemHandling == .unreadFirstThenDim)
                  ? Opacity(opacity: 0.5, child: child)
                  : child;
            },
            wrapElse: (child) => VisibilityDetector(
              key: ValueKey(item.id),
              onVisibilityChanged: (VisibilityInfo info) {
                if (info.visibleFraction >= 0.9) {
                  context.read<MainFeedCubit>().readItem(item.id);
                }
              },
              child: child,
            ),
            child: GestureDetector(
              onTap: () {
                FeedService(serverUrl!).click(item.id ?? '');
                var itemUrl = (item.url ?? '');
                if (!itemUrl.startsWith("http") && (item.guid?.startsWith('http') ?? false)) {
                  itemUrl = item.guid!;
                }
                launchUrl(Uri.parse(itemUrl));
              },
              child: builder(hovered),
            ),
          ),
        );
      },
      initialValue: false,
    );
  }
}
