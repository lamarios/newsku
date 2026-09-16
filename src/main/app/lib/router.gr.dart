// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [EmailDigestTab]
class EmailDigestRoute extends PageRouteInfo<void> {
  const EmailDigestRoute({List<PageRouteInfo>? children})
    : super(
        EmailDigestRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'EmailDigestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmailDigestTab();
    },
  );
}

/// generated route for
/// [FeedErrorsScreen]
class FeedErrorsRoute extends PageRouteInfo<FeedErrorsRouteArgs> {
  FeedErrorsRoute({Key? key, required Feed feed, List<PageRouteInfo>? children})
    : super(
        FeedErrorsRoute.name,
        args: FeedErrorsRouteArgs(key: key, feed: feed),
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'FeedErrorsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedErrorsRouteArgs>();
      return FeedErrorsScreen(key: args.key, feed: args.feed);
    },
  );
}

class FeedErrorsRouteArgs {
  const FeedErrorsRouteArgs({this.key, required this.feed});

  final Key? key;

  final Feed feed;

  @override
  String toString() {
    return 'FeedErrorsRouteArgs{key: $key, feed: $feed}';
  }
}

/// generated route for
/// [FeedScreen]
class FeedRoute extends PageRouteInfo<void> {
  const FeedRoute({List<PageRouteInfo>? children})
    : super(FeedRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'FeedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FeedScreen();
    },
  );
}

/// generated route for
/// [FeedStatsTab]
class FeedStatsRoute extends PageRouteInfo<void> {
  const FeedStatsRoute({List<PageRouteInfo>? children})
    : super(
        FeedStatsRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'FeedStatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FeedStatsTab();
    },
  );
}

/// generated route for
/// [FeedsSettingsTab]
class FeedsSettingsRoute extends PageRouteInfo<FeedsSettingsRouteArgs> {
  FeedsSettingsRoute({
    Key? key,
    bool fromFirstTimeSetup = false,
    List<PageRouteInfo>? children,
  }) : super(
         FeedsSettingsRoute.name,
         args: FeedsSettingsRouteArgs(
           key: key,
           fromFirstTimeSetup: fromFirstTimeSetup,
         ),
         initialChildren: children,
         argsEquality: false,
       );

  static const String name = 'FeedsSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedsSettingsRouteArgs>(
        orElse: () => const FeedsSettingsRouteArgs(),
      );
      return FeedsSettingsTab(
        key: args.key,
        fromFirstTimeSetup: args.fromFirstTimeSetup,
      );
    },
  );
}

class FeedsSettingsRouteArgs {
  const FeedsSettingsRouteArgs({this.key, this.fromFirstTimeSetup = false});

  final Key? key;

  final bool fromFirstTimeSetup;

  @override
  String toString() {
    return 'FeedsSettingsRouteArgs{key: $key, fromFirstTimeSetup: $fromFirstTimeSetup}';
  }
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(
        ForgotPasswordRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [GeneralSettingsTab]
class GeneralSettingsRoute extends PageRouteInfo<void> {
  const GeneralSettingsRoute({List<PageRouteInfo>? children})
    : super(
        GeneralSettingsRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'GeneralSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GeneralSettingsTab();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [InfoTab]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
    : super(InfoRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'InfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InfoTab();
    },
  );
}

/// generated route for
/// [LandingScreen]
class LandingRoute extends PageRouteInfo<void> {
  const LandingRoute({List<PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'LandingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LandingScreen();
    },
  );
}

/// generated route for
/// [LayoutSettingsTab]
class LayoutSettingsRoute extends PageRouteInfo<LayoutSettingsRouteArgs> {
  LayoutSettingsRoute({
    Key? key,
    Color? fadeColor,
    bool fromFirstTimeWizard = false,
    List<PageRouteInfo>? children,
  }) : super(
         LayoutSettingsRoute.name,
         args: LayoutSettingsRouteArgs(
           key: key,
           fadeColor: fadeColor,
           fromFirstTimeWizard: fromFirstTimeWizard,
         ),
         initialChildren: children,
         argsEquality: false,
       );

  static const String name = 'LayoutSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LayoutSettingsRouteArgs>(
        orElse: () => const LayoutSettingsRouteArgs(),
      );
      return LayoutSettingsTab(
        key: args.key,
        fadeColor: args.fadeColor,
        fromFirstTimeWizard: args.fromFirstTimeWizard,
      );
    },
  );
}

class LayoutSettingsRouteArgs {
  const LayoutSettingsRouteArgs({
    this.key,
    this.fadeColor,
    this.fromFirstTimeWizard = false,
  });

  final Key? key;

  final Color? fadeColor;

  final bool fromFirstTimeWizard;

  @override
  String toString() {
    return 'LayoutSettingsRouteArgs{key: $key, fadeColor: $fadeColor, fromFirstTimeWizard: $fromFirstTimeWizard}';
  }
}

/// generated route for
/// [LoggedInScreen]
class LoggedInRoute extends PageRouteInfo<void> {
  const LoggedInRoute({List<PageRouteInfo>? children})
    : super(LoggedInRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'LoggedInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoggedInScreen();
    },
  );
}

/// generated route for
/// [LoginFormScreen]
class LoginFormRoute extends PageRouteInfo<void> {
  const LoginFormRoute({List<PageRouteInfo>? children})
    : super(
        LoginFormRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'LoginFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginFormScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({Key? key, String? token, List<PageRouteInfo>? children})
    : super(
        ResetPasswordRoute.name,
        args: ResetPasswordRouteArgs(key: key, token: token),
        rawQueryParams: {'token': token},
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ResetPasswordRouteArgs>(
        orElse: () =>
            ResetPasswordRouteArgs(token: queryParams.optString('token')),
      );
      return ResetPasswordScreen(key: args.key, token: args.token);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, this.token});

  final Key? key;

  final String? token;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, token: $token}';
  }
}

/// generated route for
/// [ServerUrlScreen]
class ServerUrlRoute extends PageRouteInfo<void> {
  const ServerUrlRoute({List<PageRouteInfo>? children})
    : super(
        ServerUrlRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'ServerUrlRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServerUrlScreen();
    },
  );
}

/// generated route for
/// [SettingsListScreen]
class SettingsListRoute extends PageRouteInfo<void> {
  const SettingsListRoute({List<PageRouteInfo>? children})
    : super(
        SettingsListRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'SettingsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsListScreen();
    },
  );
}

/// generated route for
/// [SettingsShellScreen]
class SettingsShellRoute extends PageRouteInfo<void> {
  const SettingsShellRoute({List<PageRouteInfo>? children})
    : super(
        SettingsShellRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'SettingsShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsShellScreen();
    },
  );
}

/// generated route for
/// [SignupFormScreen]
class SignupFormRoute extends PageRouteInfo<void> {
  const SignupFormRoute({List<PageRouteInfo>? children})
    : super(
        SignupFormRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'SignupFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupFormScreen();
    },
  );
}

/// generated route for
/// [StatsScreen]
class StatsRoute extends PageRouteInfo<void> {
  const StatsRoute({List<PageRouteInfo>? children})
    : super(StatsRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'StatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StatsScreen();
    },
  );
}

/// generated route for
/// [TagStatsTab]
class TagStatsRoute extends PageRouteInfo<void> {
  const TagStatsRoute({List<PageRouteInfo>? children})
    : super(TagStatsRoute.name, initialChildren: children, argsEquality: false);

  static const String name = 'TagStatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TagStatsTab();
    },
  );
}

/// generated route for
/// [UserSettingsTab]
class UserSettingsRoute extends PageRouteInfo<void> {
  const UserSettingsRoute({List<PageRouteInfo>? children})
    : super(
        UserSettingsRoute.name,
        initialChildren: children,
        argsEquality: false,
      );

  static const String name = 'UserSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserSettingsTab();
    },
  );
}
