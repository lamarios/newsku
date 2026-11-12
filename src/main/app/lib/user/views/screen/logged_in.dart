import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
