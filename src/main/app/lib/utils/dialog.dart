import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<void> okCancelDialog(
  BuildContext context, {
  required String title,
  required Widget content,
  required Function() onOk,
  bool showCancel = true,
}) async {
  final locals = AppLocalizations.of(context)!;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
        if (showCancel) TextButton(onPressed: () => Navigator.pop(context, null), child: Text(locals.cancel)),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onOk();
          },
          child: Text(locals.ok),
        ),
      ],
    ),
  );
}

Future<String?> showTextInputDialog(BuildContext context, String title, {String? initialValue}) async {
  final TextEditingController controller = TextEditingController(text: initialValue);

  final locals = AppLocalizations.of(context)!;

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(key: Key('input-textfield'), controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Returns null
            child: Text(locals.cancel),
          ),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text(locals.ok)),
        ],
      );
    },
  ).then((value) {
    // Return null if the user cancelled OR if the string is empty
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value;
  });
}
