import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/utils.dart';
import 'package:material_ui/material_ui.dart';

class NoStats extends StatelessWidget {
  const NoStats({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    return Padding(
      padding: .only(top: pu9),
      child: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .center,
        spacing: pu6,
        children: [Icon(Icons.sentiment_neutral_outlined, size: 40), Text(locals.noStats)],
      ),
    );
  }
}
