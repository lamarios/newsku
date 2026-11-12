import 'package:app/identity/states/identity.dart';
import 'package:app/main.dart';
import 'package:material_ui/material_ui.dart';

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    var username2 = getIt.get<IdentityCubit>().currentUser?.username;
    final text = (username2 ?? '').substring(0, 1).toUpperCase();

    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: colors.secondaryContainer),
      child: Center(
        child: Text(text, style: textTheme.bodyMedium?.copyWith(color: colors.onSecondaryContainer)),
      ),
    );
  }
}
