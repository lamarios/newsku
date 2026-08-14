import 'package:app/feed/models/feed.dart';
import 'package:app/feed/views/components/feed_image.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/feed_errors.dart';
import 'package:app/settings/views/components/feed_error.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/auto_leading_button.dart';
import 'package:app/utils/views/components/page_switcher.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_loading_indicator/loading_indicator.dart';

@RoutePage()
class FeedErrorsScreen extends StatelessWidget {
  final Feed feed;

  const FeedErrorsScreen({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: NewskuAutoLeadingButton(),
        title: Row(
          spacing: pu4,
          children: [
            ClipRRect(
              borderRadius: .circular(50),
              child: FeedImage(item: feed, width: 50, height: 50),
            ),
            Expanded(child: Text(locals.feedErrorTitle(feed.name ?? ''), overflow: .ellipsis)),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => FeedErrorsCubit(FeedErrorsState(), feed: feed),

        child: BlocBuilder<FeedErrorsCubit, FeedErrorsState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: LoadingIndicator());
            } else if (state.errors.content.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: .center,
                  spacing: pu4,
                  children: [
                    Icon(Icons.check, size: 100),
                    Text(locals.nErrors(0), style: textTheme.titleLarge),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => FeedErrorView(error: state.errors.content[index]),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.errors.content.length,
                    ),
                  ),
                  PageSwitcher(
                    paginated: state.errors,
                    switchPage: (page) => context.read<FeedErrorsCubit>().switchPage(page),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
