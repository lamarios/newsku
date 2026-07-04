import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/states/main_feed.dart';
import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DrawerFeedCategory extends StatelessWidget {
  final FeedCategory category;
  final List<Feed> feeds;

  const DrawerFeedCategory({super.key, required this.category, required this.feeds});

  @override
  Widget build(BuildContext context) {
    final isMobile = BreakPoint.get(context) == .mobile;
    final cubit = context.read<MainFeedCubit>();
    return Padding(
      padding: const EdgeInsets.only(bottom: pu6),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: pu,
        children: [
          Text(category.name),
          ...feeds.map(
            (f) => Padding(
              padding: .only(left: pu3),
              child: InkWell(
                onTap: () {
                  cubit.selectFeed(f);
                  if (isMobile) {
                    cubit.toggleDrawer();
                  }
                },
                child: Row(
                  children: [
                    FeedImage(item: f, width: 15, height: 15),
                    Gap(pu),
                    Expanded(child: Text(f.name ?? '', maxLines: 1, overflow: .ellipsis)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
