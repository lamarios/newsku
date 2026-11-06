import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/states/api_keys.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/user/models/api_key.dart';
import 'package:app/utils/dialog.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/error_listener.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_loading_indicator/loading_indicator.dart';

final _dateFormat = DateFormat.yMMMd();
final _lastUsedFormat = DateFormat.yMMMd().add_Hm();

@RoutePage()
class ApiKeysSettingsTab extends StatelessWidget {
  const ApiKeysSettingsTab({super.key});

  Future<void> createApiKey(BuildContext context) async {
    final cubit = context.read<ApiKeysSettingsCubit>();
    final request = await showDialog<_NewApiKeyRequest>(context: context, builder: (context) => _NewApiKeyDialog());

    if (request == null) return;

    final created = await cubit.createApiKey(name: request.name, expiresAt: request.expiresAt);
    if (created != null && context.mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _CreatedApiKeyDialog(created: created),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    return ResponsiveSettingChild(
      title: locals.apiKeys,
      child: BlocProvider(
        create: (context) => ApiKeysSettingsCubit(ApiKeysSettingsState()),
        child: ErrorHandler<ApiKeysSettingsCubit, ApiKeysSettingsState>(
          child: BlocBuilder<ApiKeysSettingsCubit, ApiKeysSettingsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: .symmetric(horizontal: pu2),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      Container(
                        padding: .symmetric(horizontal: pu4, vertical: pu2),
                        decoration: BoxDecoration(borderRadius: .circular(5), color: colors.tertiaryContainer),
                        child: Row(
                          spacing: pu,
                          children: [
                            Icon(Icons.info_outline),
                            Expanded(child: Text(locals.apiKeysExplanation)),
                          ],
                        ),
                      ),
                      Gap(pu4),
                      Align(
                        alignment: .centerRight,
                        child: FilledButton.tonalIcon(
                          key: Key('create-api-key'),
                          onPressed: state.loading ? null : () => createApiKey(context),
                          label: Text(locals.createApiKey),
                          icon: Icon(Icons.add),
                        ),
                      ),
                      Gap(pu4),
                      if (state.loading && state.keys.isEmpty)
                        Center(child: SizedBox(width: 50, height: 50, child: LoadingIndicator()))
                      else if (state.keys.isEmpty)
                        Padding(
                          padding: .all(pu8),
                          child: Center(
                            child: Text(locals.noApiKeys, style: TextStyle(color: colors.outline)),
                          ),
                        )
                      else
                        ...state.keys.map((k) => _ApiKeyTile(apiKey: k)),
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

class _ApiKeyTile extends StatelessWidget {
  final ApiKey apiKey;

  const _ApiKeyTile({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;
    final cubit = context.read<ApiKeysSettingsCubit>();

    final created = locals.apiKeyCreatedOn(_dateFormat.format(DateTime.fromMillisecondsSinceEpoch(apiKey.timeCreated)));
    final String expiry;
    if (apiKey.expiresAt == null) {
      expiry = locals.apiKeyNeverExpires;
    } else {
      final date = _dateFormat.format(DateTime.fromMillisecondsSinceEpoch(apiKey.expiresAt!));
      expiry = apiKey.expired ? locals.apiKeyExpiredOn(date) : locals.apiKeyExpiresOn(date);
    }
    final lastUsed = apiKey.lastUsed == null
        ? locals.apiKeyNeverUsed
        : locals.apiKeyLastUsed(_lastUsedFormat.format(DateTime.fromMillisecondsSinceEpoch(apiKey.lastUsed!)));

    return ListTile(
      contentPadding: .zero,
      leading: Icon(Icons.key, color: apiKey.expired ? colors.error : null),
      title: Text(apiKey.name),
      subtitle: Text('$created · $expiry\n$lastUsed', style: apiKey.expired ? TextStyle(color: colors.error) : null),
      trailing: IconButton(
        tooltip: locals.delete,
        icon: Icon(Icons.delete),
        onPressed: () => okCancelDialog(
          context,
          title: locals.delete,
          content: Text(locals.deleteApiKeyExplanation),
          onOk: () => cubit.deleteApiKey(apiKey),
        ),
      ),
    );
  }
}

enum _Expiry {
  never(null),
  days30(30),
  days90(90),
  year(365),
  custom(null);

  final int? days;

  const _Expiry(this.days);
}

class _NewApiKeyRequest {
  final String name;
  final DateTime? expiresAt;

  const _NewApiKeyRequest(this.name, this.expiresAt);
}

class _NewApiKeyDialog extends StatefulWidget {
  @override
  State<_NewApiKeyDialog> createState() => _NewApiKeyDialogState();
}

class _NewApiKeyDialogState extends State<_NewApiKeyDialog> {
  final TextEditingController name = TextEditingController();
  _Expiry expiry = .days90;
  DateTime? customDate;

  @override
  void initState() {
    super.initState();
    name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  DateTime? get expiresAt {
    final now = DateTime.now();
    return switch (expiry) {
      .never => null,
      .custom => customDate,
      _ => DateTime(now.year, now.month, now.day + expiry.days!),
    };
  }

  bool get valid => name.text.trim().isNotEmpty && (expiry != .custom || customDate != null);

  Future<void> pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: customDate ?? now.add(Duration(days: 30)),
      firstDate: now.add(Duration(days: 1)),
      lastDate: now.add(Duration(days: 365 * 10)),
    );
    if (date != null) {
      setState(() => customDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final date = expiresAt;

    return AlertDialog(
      title: Text(locals.createApiKey),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          TextField(
            key: Key('api-key-name'),
            controller: name,
            autofocus: true,
            decoration: InputDecoration(label: Text(locals.apiKeyName)),
          ),
          Gap(pu4),
          DropdownMenu<_Expiry>(
            key: Key('api-key-expiry'),
            expandedInsets: .zero,
            label: Text(locals.apiKeyExpiry),
            initialSelection: expiry,
            onSelected: (value) {
              setState(() => expiry = value ?? .never);
              if (value == .custom) pickDate();
            },
            dropdownMenuEntries: _Expiry.values
                .map((e) => DropdownMenuEntry(value: e, label: locals.apiKeyExpiryOption(e.name)))
                .toList(),
          ),
          Gap(pu2),
          if (expiry == .custom)
            Align(
              alignment: .centerLeft,
              child: TextButton.icon(
                onPressed: pickDate,
                icon: Icon(Icons.calendar_today),
                label: Text(date == null ? locals.apiKeyPickDate : _dateFormat.format(date)),
              ),
            )
          else
            Text(date == null ? locals.apiKeyNeverExpires : locals.apiKeyExpiresOn(_dateFormat.format(date))),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(locals.cancel)),
        TextButton(
          key: Key('api-key-create-confirm'),
          onPressed: valid ? () => Navigator.pop(context, _NewApiKeyRequest(name.text.trim(), expiresAt)) : null,
          child: Text(locals.create),
        ),
      ],
    );
  }
}

class _CreatedApiKeyDialog extends StatelessWidget {
  final CreatedApiKey created;

  const _CreatedApiKeyDialog({required this.created});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(locals.apiKeyCreatedTitle),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Text(locals.apiKeyCreatedExplanation),
          Gap(pu4),
          Container(
            padding: .all(pu2),
            decoration: BoxDecoration(borderRadius: .circular(5), color: colors.surfaceContainerHighest),
            child: Row(
              spacing: pu2,
              children: [
                Expanded(
                  child: SelectableText(
                    created.key,
                    key: Key('created-api-key'),
                    style: textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
                  ),
                ),
                IconButton(
                  tooltip: locals.copy,
                  icon: Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: created.key));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locals.copiedToClipboard)));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(locals.done))],
    );
  }
}
