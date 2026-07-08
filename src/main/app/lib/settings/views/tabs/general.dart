import 'dart:io';
import 'dart:ui';

import 'package:app/home/state/local_preferences.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/settings/states/general.dart';
import 'package:app/user/models/read_item_handling.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:motor/motor.dart';

@RoutePage()
class GeneralSettingsTab extends StatelessWidget {
  const GeneralSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    final subTextTheme = textTheme.labelMedium?.copyWith(color: colors.secondary);

    return Padding(
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
                    Gap(pu4),
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
                    Gap(pu8),
                    Divider(),
                    Gap(pu8),
                    Container(
                      padding: .symmetric(horizontal: pu4, vertical: pu2),
                      decoration: BoxDecoration(borderRadius: .circular(5), color: colors.tertiaryContainer),
                      child: Row(spacing: pu, children: [Icon(Icons.info_outline), Text(locals.deviceOnlySettings)]),
                    ),
                    Gap(pu4),
                    SwitchListTile(
                      contentPadding: .zero,
                      title: Text(locals.blackBackground),
                      subtitle: Text(locals.blackBackgroundExplanation, style: subTextTheme),
                      value: context.select((LocalPreferencesCubit p) => p.state.blackBackground),
                      onChanged: (value) => getIt.get<LocalPreferencesCubit>().setBlackBackground(value),
                    ),
                    Row(
                      spacing: pu2,
                      children: [
                        Expanded(child: Text(locals.theme)),
                        DropdownMenu<ThemeMode>(
                          initialSelection: context.select((LocalPreferencesCubit p) => p.state.theme),
                          onSelected: (value) =>
                              getIt.get<LocalPreferencesCubit>().setBrightness(value ?? ThemeMode.system),
                          dropdownMenuEntries: ThemeMode.values
                              .map((h) => DropdownMenuEntry(value: h, label: locals.appTheme(h.name)))
                              .toList(),
                        ),
                      ],
                    ),
                    Text(locals.appColor),
                    Gap(pu2),
                    if (!kIsWeb && Platform.isAndroid) ...[
                      SwitchListTile(
                        contentPadding: .zero,
                        title: Text(locals.dynamicColor),
                        subtitle: Text(locals.blackBackgroundExplanation, style: subTextTheme),
                        value: context.select((LocalPreferencesCubit p) => p.state.dynamicColor),
                        onChanged: (value) => getIt.get<LocalPreferencesCubit>().setDynamicColor(value),
                      ),
                      Gap(pu2),
                    ],
                    if (!context.select((LocalPreferencesCubit p) => p.state.dynamicColor))
                      Wrap(
                        spacing: pu4,
                        runSpacing: pu4,
                        children:
                            [
                              Colors.deepOrange,
                              Colors.deepPurple,
                              Colors.amber,
                              Colors.green,
                              Colors.pink,
                              Colors.blue,
                              Colors.grey,
                              Colors.red,
                              Colors.teal,
                            ].map((c) {
                              return InkWell(
                                onTap: () => getIt.get<LocalPreferencesCubit>().setColor(c),
                                child: SingleMotionBuilder(
                                  from: 0,
                                  value:
                                      context.select((LocalPreferencesCubit p) => p.state.themeColor).toARGB32() ==
                                          c.toARGB32()
                                      ? 1
                                      : 0,
                                  motion: MaterialSpringMotion.expressiveSpatialSlow(),
                                  builder: (context, value, child) => Transform.scale(
                                    scale: lerpDouble(1, 1.3, value),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: c,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Color.lerp(colors.surface, colors.tertiary, value)!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                    /*
                    Gap(pu8),
                    Text(locals.density),
                    Row(
                      children: [
                        Text(locals.dense, style: textTheme.labelSmall),
                        Expanded(
                          child: Slider(
                            min: 1,
                            max: 8,
                            divisions: 8,
                            value: pu,
                            onChanged: (double value) => getIt.get<LocalPreferencesCubit>().setDensity(value),
                          ),
                        ),

                        Text(locals.spacious, style: textTheme.labelSmall),
                      ],
                    ),
*/
                    Gap(pu8),
                    Divider(),
                    Gap(pu8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
