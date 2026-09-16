import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/general.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/user/models/read_item_handling.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class GeneralSettingsTab extends StatelessWidget {
  const GeneralSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    final subTextTheme = textTheme.labelMedium?.copyWith(color: colors.secondary);

    return ResponsiveSettingChild(
      title: locals.articlePreference,
      child: Padding(
        padding: .symmetric(horizontal: pu2),
        child: BlocProvider(
          create: (context) => GeneralSettingsCubit(GeneralSettingsState()),
          child: BlocBuilder<GeneralSettingsCubit, GeneralSettingsState>(
            builder: (context, state) {
              final cubit = context.read<GeneralSettingsCubit>();
              return ErrorHandler<GeneralSettingsCubit, GeneralSettingsState>(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(locals.articlePreference),
                      TextField(
                        key: Key('article-preferences'),
                        controller: cubit.preferenceController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          helper: Text(locals.articlePreferencesExplanation, style: subTextTheme),
                        ),
                      ),
                      Gap(pu2),
                      Align(
                        alignment: .centerRight,
                        child: FilledButton.tonalIcon(
                          onPressed: state.loading
                              ? null
                              : () async {
                                  await cubit.setAiPreferences();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(SnackBar(content: Text(locals.preferenceUpdated)));
                                  }
                                },
                          label: Text(locals.update),
                          icon: Icon(Icons.save),
                        ),
                      ),
                      Gap(pu8),
                      Divider(),
                      Gap(pu8),
                      Text(locals.minimumNewsScore),
                      Text(locals.minimumNewsScoreExplanation, style: subTextTheme),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 20,
                        label: state.user?.minimumImportance.toString(),
                        value: (state.user?.minimumImportance ?? 0).toDouble(),
                        onChanged: (double value) => cubit.setAndSaveImportance(value),
                      ),
                      Gap(pu4),
                      Row(
                        spacing: pu2,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .stretch,
                              children: [
                                Text(locals.readItemHandling),
                                Text(locals.readItemHandlingExplanation, style: subTextTheme),
                              ],
                            ),
                          ),
                          DropdownMenu<ReadItemHandling>(
                            key: Key('read-item-handling'),
                            initialSelection: state.user?.readItemHandling ?? ReadItemHandling.none,
                            onSelected: cubit.setReadItemPreference,
                            dropdownMenuEntries: ReadItemHandling.values
                                .map((h) => DropdownMenuEntry(value: h, label: h.getLabel(context)))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
