// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get articlePreference => 'Article preferences';

  @override
  String get server => 'Server';

  @override
  String get continueToLogin => 'Continue';

  @override
  String get serverUrlUnreachable => 'Couldn\'t read server or get its config';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get signUp => 'Sign up';

  @override
  String get login => 'Log in';

  @override
  String get or => 'or';

  @override
  String loginWith(Object provider) {
    return 'Log in with $provider';
  }

  @override
  String get invalidCredentials => 'Invalid username or password';

  @override
  String get email => 'Email';

  @override
  String get repeatPassword => 'RepeatPassword';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get noNews => 'No news';

  @override
  String readItems(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count read items',
      one: '1 read item',
      zero: 'No read items',
    );
    return '$_temp0';
  }

  @override
  String get loadMore => 'Load more';

  @override
  String get reasoning => 'Reasoning';

  @override
  String get search => 'Search';

  @override
  String get feeds => 'Feeds';

  @override
  String get layout => 'Layout';

  @override
  String get general => 'General';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get addFeed => 'Add feed';

  @override
  String get newFeedUrl => 'New feed URL';

  @override
  String get import => 'Import';

  @override
  String get export => 'Export';

  @override
  String get deleteFeed => 'Delete feed?';

  @override
  String get deleteFeedMessage => 'This will delete the feed and all its articles';

  @override
  String importedNFeeds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importer $count feeds',
      one: 'Imported 1 feed',
      zero: 'No feed imported',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'Ok';

  @override
  String get layoutExplanation =>
      'In this screen you can adjust how your RSS feed articles are being displayed by arranging the different types of blocks the way you want it. Your feed items will be inserted from most important to least important following the blocks top to bottom.\n\nNote that the Fixed article blocks on mobile will be displayed in a similar way as the big grid items.';

  @override
  String get availableBlocks => 'Available blocks';

  @override
  String get dragAndDropInstructions => 'Drag and drop the blocks onto your layout to personalize your home page';

  @override
  String get fixedArticleCountBlocks => 'Fixed article count blocks';

  @override
  String get dynamicArticleCountBlocks => 'Dynamic article count blocks';

  @override
  String get headline => 'Headline';

  @override
  String get headlinePicture => 'Headline on picture';

  @override
  String get bigGridPicture => 'Big picture grid';

  @override
  String get singleItemRow => 'List';

  @override
  String get topStories => 'Top stories';

  @override
  String get bigGrid => 'Big grid';

  @override
  String get smallGrid => 'Small grid';

  @override
  String get title => 'Title';

  @override
  String nItems(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get currentLayout => 'Current layout';

  @override
  String get layoutMustFinishWithDynamicBlock => 'Your layout must finish with a dynamic block';

  @override
  String get update => 'Update';

  @override
  String get layoutSaved => 'Layout saved';

  @override
  String get articlePreferencesExplanation =>
      'This is guidance for the AI model. Telling it what kind of article you prefer to prioritize for the scoring  of each article. The change only applies to future articles.';

  @override
  String get minimumNewsScore => 'Minimum news score';

  @override
  String get minimumNewsScoreExplanation =>
      'This will filter out from your feed any news that has been scored lower than the selected value';

  @override
  String get preferenceUpdated => 'Preferences updated';

  @override
  String get readItemHandling => 'Read item handling';

  @override
  String get readItemHandlingExplanation =>
      'While you scroll through the feed, items will be set as read. Select how you want to handle the read items in your feed';

  @override
  String get appColor => 'App color';

  @override
  String get blackBackground => 'Black background';

  @override
  String get blackBackgroundExplanation => 'Use black background for the dark theme';

  @override
  String get dynamicColor => 'Dynamic color';

  @override
  String get dynamicColorExplanation => 'User device accent color';

  @override
  String get changePassword => 'Change password';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordUpdated => 'Password updated';

  @override
  String get dropBlockHere => 'Drop block here';

  @override
  String itemHandlingLabel(String handling) {
    String _temp0 = intl.Intl.selectLogic(handling, {
      'none': 'Display normally',
      'dim': 'Dim',
      'hide': 'Hide',
      'unreadFirstThenDim': 'Unread first then dim',
      'other': 'No handling selected',
    });
    return '$_temp0';
  }

  @override
  String get next => 'Next';

  @override
  String get firstTimeSetup => 'First time setup';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get setupComplete => 'Setup complete !';

  @override
  String get welcomeText =>
      'Welcome to Newsku!\n\nThis walkthrough will help you complete the initial configuration of the application.You can adjust any of these settings later in the Application Settings menu.';

  @override
  String get noFeeds => 'No feeds added, either add a feed via its url or import an OPML file';

  @override
  String get addBlock => 'Add block';

  @override
  String get selectBlock => 'Select block type to add to your layout';

  @override
  String nErrors(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count errors',
      one: '1 error',
      zero: 'No errors',
    );
    return '$_temp0';
  }

  @override
  String get duringLastRefreshAttempt => 'During last refresh attempt';

  @override
  String feedErrorTitle(Object feedName) {
    return '$feedName errors';
  }

  @override
  String get error => 'Error';

  @override
  String get stackTrace => 'Stack trace';

  @override
  String get articleUrl => 'Article URL';

  @override
  String get feedRetrievalError => 'Error while querying the RSS feed URL';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Build number';

  @override
  String get package => 'Package';

  @override
  String get backendVersion => 'Backend version';

  @override
  String get licenses => 'Show License';

  @override
  String get feedback => 'Send feedback';

  @override
  String get backendUrl => 'Backend URL';

  @override
  String get submitFeedback => 'Submit feedback';

  @override
  String get submitFeedbackDescription =>
      'Found a bug or have a suggestion? Use this tool to take screenshot of the app, annotate and submit feedback';

  @override
  String get feedbackDisclaimer =>
      'To submit feedback you will need a GitHub account and your screenshot will be submitted to Imgur anonymously.';

  @override
  String get density => 'UI Density';

  @override
  String get dense => 'Dense';

  @override
  String get spacious => 'Spacious';

  @override
  String get deviceOnlySettings => 'The settings in this section are saved on the device';

  @override
  String get stats => 'Stats';

  @override
  String get tags => 'Tags';

  @override
  String get tagStatsExplanation =>
      'This page show how many times you clicked on articles with the following tags in the last 30 days. Those stats are used when the AI model scores the importance of an article';

  @override
  String get feedStatsExplanation =>
      'This page show how many times you clicked on articles from a given feed in the last 30 days';

  @override
  String get noStats => 'No stats available, stats are only recorded once you click on an article in your feed';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get save => 'Save';

  @override
  String get invalidLink => 'Invalid link';

  @override
  String get invalidLinkExplanation => 'This reset password link is invalid. It might also be expired.';

  @override
  String get passwordReset => 'Password reset';

  @override
  String get passwordResetExplanation => 'Your password has been reset, you can now log in with your new password';

  @override
  String get forgotPassword => 'Forgot password ?';

  @override
  String get submit => 'Submit';

  @override
  String get submitted => 'Submitted';

  @override
  String get passwordResetRequestSubmitted => 'Password reset request submitted';

  @override
  String get theme => 'Theme';

  @override
  String appTheme(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {'light': 'Light', 'dark': 'Dark', 'other': 'Follow system'});
    return '$_temp0';
  }

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get user => 'User';

  @override
  String get emailDigestTitle => 'Email digest';

  @override
  String emailDigest(String digest) {
    String _temp0 = intl.Intl.selectLogic(digest, {
      'daily': 'Daily',
      'weekly': 'Weekly',
      'monthly': 'Montly',
      'other': '$digest',
    });
    return '$_temp0';
  }

  @override
  String get emailDigestExplanation =>
      'Receive periodic emails with the top rated articles in the past selected period';

  @override
  String get changeEmail => 'Change email';

  @override
  String get newEmail => 'New email';

  @override
  String get emailUpdated => 'Email updated';

  @override
  String get invalidUrl => 'Invalid URL';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get addCategory => 'Add category';

  @override
  String get noFeedInCategory => 'No feed in category, drag and drop them here';

  @override
  String get rename => 'Rename';

  @override
  String get delete => 'Delete';

  @override
  String get deleteCategoryExplanation =>
      'Deleting a category will also delete all the feeds it contains. This cannot be undone';

  @override
  String get any => 'Any';

  @override
  String get feedCategory => 'Category';

  @override
  String get layoutBlockCategoryExplanation => 'This block will only display blocks of the selected category';
}
