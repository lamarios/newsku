import 'dart:math';

import 'package:app/utils/models/pagination.dart';
import 'package:app/utils/views/components/conditional_wrap.dart';
import 'package:material_ui/material_ui.dart';

class PageSwitcher extends StatelessWidget {
  final Paginated paginated;
  final void Function(int page) switchPage;

  const PageSwitcher({super.key, required this.paginated, required this.switchPage});

  @override
  Widget build(BuildContext context) {
    if (paginated.totalPages <= 1) {
      return SizedBox.shrink();
    }

    final current = paginated.number;
    List<Widget> center = [];

    var start = max(1, current - 3);

    if (start > 1) {
      center.add(Text('...'));
    }

    var end = min(current + 3, paginated.totalPages - 1);
    for (int i = start; i < end; i++) {
      center.add(_Page(page: i, currentPage: current, switchPage: switchPage));
    }
    if (end < paginated.totalPages - 1) {
      center.add(Text('...'));
    }

    return Row(
      mainAxisAlignment: .center,
      children: [
        _Page(page: 0, currentPage: current, switchPage: switchPage),
        ...center,
        _Page(page: paginated.totalPages - 1, currentPage: current, switchPage: switchPage),
      ],
    );
  }
}

class _Page extends StatelessWidget {
  final int page;
  final int currentPage;
  final void Function(int page) switchPage;

  const _Page({required this.page, required this.currentPage, required this.switchPage});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ConditionalWrap(
      wrapIf: page == currentPage,
      wrapper: (child) => Container(
        decoration: BoxDecoration(color: colors.secondaryContainer, borderRadius: .circular(100)),
        child: child,
      ),
      child: TextButton(onPressed: () => switchPage(page), child: Text('${page + 1}')),
    );
  }
}
