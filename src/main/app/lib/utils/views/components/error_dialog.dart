import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/models/breakpoints.dart';
import 'package:app/utils/models/newsku_error.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';

class ErrorDialog extends StatelessWidget {
  final dynamic error;
  final StackTrace? trace;

  const ErrorDialog({super.key, required this.error, this.trace});

  static void show(BuildContext context, {required dynamic error, StackTrace? trace}) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(error: error, trace: trace),
    );
  }

  static void showSnack(BuildContext context, {required dynamic error, StackTrace? trace}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildError(context, error, trace),
        ),
      ),
    );
  }

  static List<Widget> buildError(BuildContext context, dynamic error, StackTrace? trace) {
    if (error is NewskuError) {
      return [Text(error.message)];
    } else {
      return [Text(error.toString())];
    }
    // we really don't know what's going on
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: BreakPoint.mobile.maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: .only(top: pu4, left: pu4),
              child: Text('Error', style: textTheme.headlineSmall),
            ),
            Gap(pu5),
            Flexible(
              child: SingleChildScrollView(child: Column(children: [...buildError(context, error, trace)])),
            ),
            Gap(pu5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(locals.ok))],
            ),
          ],
        ),
      ),
    );
  }
}
