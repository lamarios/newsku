import 'package:app/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

enum ReadItemHandling {
  none,
  dim,
  hide,
  unreadFirstThenDim;

  String getLabel(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return locals.itemHandlingLabel(name);
  }
}
