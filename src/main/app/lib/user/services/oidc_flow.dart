import 'package:app/config/models/oidc_config.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:oidc/oidc.dart';

final _log = Logger('OidcFlow');

/// Runs the OIDC authorization code flow with the provider and returns the access token, used both to log in and to
/// link an SSO account to an existing user.
Future<String?> getOidcAccessToken(OidcConfig config) async {
  final manager = await _setupClient(config);

  OidcProviderMetadata? override;

  // PKCE handling
  if (kIsWeb) {
    final sha256 = OidcConstants_AuthorizeRequest_CodeChallengeMethod.s256;
    override = manager.discoveryDocument.copyWith(codeChallengeMethodsSupported: [sha256]);
  }

  final user = await manager.loginAuthorizationCodeFlow(discoveryDocumentOverride: override);

  return user?.token.accessToken;
}

Future<OidcUserManager> _setupClient(OidcConfig config) async {
  try {
    _log.fine("Setting oidc client");

    var basePort = Uri.base.port;

    String webUrl = kIsWeb
        ? '${Uri.base.scheme}://${Uri.base.host}${basePort != 80 && basePort != 443 ? ':$basePort' : ''}/redirect.html'
        : '';

    _log.fine(config);
    var redirectUri = kIsWeb
        // this url must be an actual html page.
        // see the file in /web/redirect.html for an example.
        //
        // for debugging in flutter, you must run this app with --web-port 22433
        ? Uri.parse(webUrl)
        : Uri.parse('com.github.lamarios.newsku:/oidcRedirect');
    final manager = OidcUserManager.lazy(
      discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(Uri.parse(config.issuer)),
      clientCredentials: OidcClientAuthentication.none(clientId: config.clientId),
      store: OidcMemoryStore(),
      settings: OidcUserManagerSettings(
        postLogoutRedirectUri: redirectUri,
        frontChannelLogoutUri: Uri(
          path: webUrl,
        ).replace(queryParameters: {...redirectUri.queryParameters, 'requestType': 'front-channel-logout'}),
        scope: ["openid", 'profile', 'email'],
        redirectUri: redirectUri,
        options: OidcPlatformSpecificOptions(
          web: OidcPlatformSpecificOptions_Web(broadcastChannel: 'oidc_flutter_web/redirect'),
        ),
      ),
    );

    await manager.init();
    return manager;
  } catch (e) {
    _log.severe(e);
    rethrow;
  }
}
