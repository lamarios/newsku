import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/user/services/user_service.dart';
import 'package:app/utils/utils.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LlmPreference extends StatelessWidget {
  const LlmPreference({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    var identityCubit = context.read<IdentityCubit>();
    var currentUser = identityCubit.currentUser;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pu6),
      child: Column(
        mainAxisSize: .min,
        spacing: pu4,
        children: [
          Text(locals.articlePreferencesExplanation),
          TextFormField(
            initialValue: currentUser?.feedItemPreference ?? '',
            maxLines: 5,
            onChanged: (value) {
              if (currentUser != null) {
                EasyDebounce.debounce('first setup llm preference', Duration(milliseconds: 500), () async {
                  await UserService(serverUrl!).updateUser(currentUser.copyWith(feedItemPreference: value));
                  identityCubit.getUser();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
