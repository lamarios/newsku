import 'dart:convert';
import 'dart:io';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/settings/views/components/responsive_setting_child.dart';
import 'package:app/utils/models/imgur_error.dart';
import 'package:app/utils/service/imgur_service.dart';
import 'package:app/utils/utils.dart';
import 'package:app/utils/views/components/app_logo.dart';
import 'package:app/utils/views/components/app_name.dart';
import 'package:auto_route/annotations.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:material_loading_indicator/loading_indicator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final _log = Logger('InfoTab');

@RoutePage()
class InfoTab extends StatelessWidget {
  const InfoTab({super.key});

  Future<void> sendFeedBack(BuildContext context, UserFeedback feedback) async {
    try {
      // workaround to avoid the app to be offset after sending feedback
      // see https://github.com/ueman/feedback/issues/322
      await Future.delayed(const Duration(seconds: 1));

      BetterFeedback.of(context).hide();

      final deviceInfo = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();

      String deviceLine = '';
      if (kIsWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        deviceLine =
            '**Runtime info:**\n[Device] User agent: ${webBrowserInfo.userAgent} / Browser: ${webBrowserInfo.browserName}';
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceLine =
            '**Runtime info:**\n[Device] Manufacturer: ${androidInfo.manufacturer} / Brand: ${androidInfo.brand} / Model: ${androidInfo.model} / Hardware: ${androidInfo.hardware}';
        deviceLine +=
            '\n[Device] Version: ${androidInfo.version.release}.${androidInfo.version.incremental} (${androidInfo.version.codename})';
      }

      _log.fine(deviceLine);

      final firstLine = feedback.text.split('\n')[0];

      String body = deviceLine;
      body += '\n[Newsku] Version: ${packageInfo.version} Build: ${packageInfo.buildNumber}';
      body += '\n[Backend] Version: ${config?.backendVersion ?? '-'}';

      body += '\n\n\n**Feedback:**\n${feedback.text}\n\n\n';

      String screenshotUrl = await ImgurService().uploadImageToImgur(base64Encode(feedback.screenshot));
      body += '\n**Screenshot:**\n![app screenshot]($screenshotUrl)';

      final url =
          'https://github.com/lamarios/newsku/issues/new?title=${Uri.encodeComponent('[App Feedback] $firstLine')}&body=${Uri.encodeComponent(body)}';
      await launchUrl(Uri.parse(url));
    } catch (err) {
      if (err is ImgurError) {
        _log.severe("Issue while submitting feedback, img error: ${err.error}", err);
      } else {
        _log.severe("Issue while submitting feedback", err);
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locals = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    var titlesTheme = textTheme.labelSmall?.copyWith(color: colors.tertiary);

    return ResponsiveSettingChild(
      title: locals.about,
      child: SelectionArea(
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) => snapshot.data == null
              ? Center(child: LoadingIndicator())
              : Column(
                  crossAxisAlignment: .center,

                  children: [
                    Gap(pu4),
                    AppLogo(size: 75),
                    Gap(pu6),
                    AppName(style: textTheme.displaySmall, alignment: .center),
                    Gap(pu6),
                    Text(locals.version, style: titlesTheme),
                    Text(snapshot.data?.version ?? '-'),
                    Gap(pu2),
                    Text(locals.buildNumber, style: titlesTheme),
                    Text(snapshot.data?.buildNumber ?? '-'),
                    Gap(pu2),
                    Text(locals.backendVersion, style: titlesTheme),
                    Text(serverUrl ?? '-'),
                    Gap(pu2),
                    Text(locals.backendVersion, style: titlesTheme),
                    Text(config?.backendVersion ?? '-'),
                    Gap(pu6),
                    FilledButton.tonalIcon(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        showLicensePage(context: context, applicationIcon: AppLogo(size: 20));
                      },
                      label: Text(locals.licenses),
                    ),
                    /*
                    Gap(pu6),
                    FilledButton.tonalIcon(
                      icon: Icon(Icons.feedback),
                      onPressed: () {
                        okCancelDialog(
                          context,
                          title: locals.submitFeedback,
                          content: Text(locals.feedbackDisclaimer),
                          onOk: () => BetterFeedback.of(context).show((feedback) => sendFeedBack(context, feedback)),
                        );
                      },
                      label: Text(locals.feedback),
                    ),
      */
                  ],
                ),
        ),
      ),
    );
  }
}
