import 'dart:io';
import 'dart:ui';

import 'package:app/home/state/local_preferences.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/router.dart';
import 'package:app/settings/states/main_settings.dart';
import 'package:app/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:motor/motor.dart';

class SettingsMasterList extends StatelessWidget {
  final String selectedRouteName;
  final Function(PageRouteInfo route) onTap;

  const SettingsMasterList({super.key, required this.selectedRouteName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;
    final subTextTheme = textTheme.labelMedium?.copyWith(color: colors.secondary);

    return BlocProvider(
      create: (context) => MainSettingsCubit(MainSettingsState()),
      child: BlocBuilder<MainSettingsCubit, MainSettingsState>(
        builder: (context, state) {
          return Align(
            alignment: .topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  _SectionTitle(title: locals.content),
                  ListTile(
                    title: Text(locals.feeds),
                    leading: Icon(Icons.rss_feed),
                    trailing: Icon(Icons.chevron_right),
                    subtitle: Text(locals.nFeedsAndCategories(state.categories, state.feeds)),
                    onTap: () => onTap(FeedsSettingsRoute()),
                  ),
                  ListTile(
                    title: Text(locals.layout),
                    leading: Icon(Icons.grid_view_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => onTap(LayoutSettingsRoute()),
                  ),
                  _SectionTitle(title: locals.appearance, topPadding: true),
                  ListTile(
                    title: Container(
                      padding: .symmetric(horizontal: pu4, vertical: pu2),
                      decoration: BoxDecoration(borderRadius: .circular(5), color: colors.tertiaryContainer),
                      child: Row(
                        spacing: pu,
                        children: [
                          Icon(Icons.info_outline),
                          Expanded(child: Text(locals.deviceOnlySettings)),
                        ],
                      ),
                    ),
                  ),
                  if (!kIsWeb && Platform.isAndroid) ...[
                    SwitchListTile(
                      title: Text(locals.dynamicColor),
                      subtitle: Text(locals.blackBackgroundExplanation, style: subTextTheme),
                      value: context.select((LocalPreferencesCubit p) => p.state.dynamicColor),
                      onChanged: (value) => getIt.get<LocalPreferencesCubit>().setDynamicColor(value),
                    ),
                    Gap(pu4),
                  ],
                  SwitchListTile(
                    title: Text(locals.blackBackground),
                    subtitle: Text(locals.blackBackgroundExplanation, style: subTextTheme),
                    value: context.select((LocalPreferencesCubit p) => p.state.blackBackground),
                    onChanged: (value) => getIt.get<LocalPreferencesCubit>().setBlackBackground(value),
                  ),
                  ListTile(
                    title: Text(locals.theme),
                    trailing: DropdownMenu<ThemeMode>(
                      initialSelection: context.select((LocalPreferencesCubit p) => p.state.theme),
                      onSelected: (value) =>
                          getIt.get<LocalPreferencesCubit>().setBrightness(value ?? ThemeMode.system),
                      dropdownMenuEntries: ThemeMode.values
                          .map((h) => DropdownMenuEntry(value: h, label: locals.appTheme(h.name)))
                          .toList(),
                    ),
                  ),
                  if (!context.select((LocalPreferencesCubit p) => p.state.dynamicColor))
                    ListTile(
                      title: Text(locals.appColor),
                      subtitle: Padding(
                        padding: .only(top: pu),
                        child: Wrap(
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
                      ),
                    ),
                  _SectionTitle(title: locals.account, topPadding: true),
                  Builder(
                    builder: (context) {
                      final digest = context.select((IdentityCubit c) => c.currentUser?.emailDigest ?? []);
                      return ListTile(
                        title: Text(locals.emailDigestTitle),
                        subtitle: (digest.isEmpty)
                            ? Text(locals.emailDigestExplanation)
                            : Text((digest).map((d) => locals.emailDigest(d.name)).join(", ")),

                        leading: Icon(Icons.email),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => onTap(EmailDigestRoute()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(locals.emailAndPassword),
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => onTap(UserSettingsRoute()),
                  ),
                  ListTile(
                    title: Text(locals.about),
                    leading: Icon(Icons.info),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => onTap(InfoRoute()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool topPadding;

  const _SectionTitle({required this.title, this.topPadding = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: .only(left: pu4, top: topPadding ? pu8 : 0),
      child: Text(title, style: textTheme.titleSmall?.copyWith(color: colors.outline)),
    );
  }
}
