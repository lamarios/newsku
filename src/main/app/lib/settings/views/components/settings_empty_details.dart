import 'package:material_ui/material_ui.dart';

class SettingsEmptyDetails extends StatelessWidget {
  const SettingsEmptyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(child: Icon(Icons.settings, size: 100, color: colors.outline));
  }
}
