import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @articlePreference.
  ///
  /// In en, this message translates to:
  /// **'Article preferences'**
  String get articlePreference;

  /// No description provided for @server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @continueToLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueToLogin;

  /// No description provided for @serverUrlUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read server or get its config'**
  String get serverUrlUnreachable;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @loginWith.
  ///
  /// In en, this message translates to:
  /// **'Log in with {provider}'**
  String loginWith(Object provider);

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get invalidCredentials;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'RepeatPassword'**
  String get repeatPassword;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @noNews.
  ///
  /// In en, this message translates to:
  /// **'No news'**
  String get noNews;

  /// No description provided for @readItems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No read items} =1{1 read item} other{{count} read items}}'**
  String readItems(num count);

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @reasoning.
  ///
  /// In en, this message translates to:
  /// **'Reasoning'**
  String get reasoning;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @feeds.
  ///
  /// In en, this message translates to:
  /// **'Feeds'**
  String get feeds;

  /// No description provided for @layout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layout;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @addFeed.
  ///
  /// In en, this message translates to:
  /// **'Add feed'**
  String get addFeed;

  /// No description provided for @newFeedUrl.
  ///
  /// In en, this message translates to:
  /// **'New feed URL'**
  String get newFeedUrl;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @deleteFeed.
  ///
  /// In en, this message translates to:
  /// **'Delete feed?'**
  String get deleteFeed;

  /// No description provided for @deleteFeedMessage.
  ///
  /// In en, this message translates to:
  /// **'This will delete the feed and all its articles'**
  String get deleteFeedMessage;

  /// No description provided for @importedNFeeds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No feed imported} =1{Imported 1 feed} other{Importer {count} feeds}}'**
  String importedNFeeds(num count);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @layoutExplanation.
  ///
  /// In en, this message translates to:
  /// **'In this screen you can adjust how your RSS feed articles are being displayed by arranging the different types of blocks the way you want it. Your feed items will be inserted from most important to least important following the blocks top to bottom.\n\nNote that the Fixed article blocks on mobile will be displayed in a similar way as the big grid items.'**
  String get layoutExplanation;

  /// No description provided for @availableBlocks.
  ///
  /// In en, this message translates to:
  /// **'Available blocks'**
  String get availableBlocks;

  /// No description provided for @dragAndDropInstructions.
  ///
  /// In en, this message translates to:
  /// **'Drag and drop the blocks onto your layout to personalize your home page'**
  String get dragAndDropInstructions;

  /// No description provided for @fixedArticleCountBlocks.
  ///
  /// In en, this message translates to:
  /// **'Fixed article count blocks'**
  String get fixedArticleCountBlocks;

  /// No description provided for @dynamicArticleCountBlocks.
  ///
  /// In en, this message translates to:
  /// **'Dynamic article count blocks'**
  String get dynamicArticleCountBlocks;

  /// No description provided for @headline.
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get headline;

  /// No description provided for @headlinePicture.
  ///
  /// In en, this message translates to:
  /// **'Headline on picture'**
  String get headlinePicture;

  /// No description provided for @bigGridPicture.
  ///
  /// In en, this message translates to:
  /// **'Big picture grid'**
  String get bigGridPicture;

  /// No description provided for @singleItemRow.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get singleItemRow;

  /// No description provided for @topStories.
  ///
  /// In en, this message translates to:
  /// **'Top stories'**
  String get topStories;

  /// No description provided for @bigGrid.
  ///
  /// In en, this message translates to:
  /// **'Big grid'**
  String get bigGrid;

  /// No description provided for @smallGrid.
  ///
  /// In en, this message translates to:
  /// **'Small grid'**
  String get smallGrid;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @nItems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String nItems(num count);

  /// No description provided for @currentLayout.
  ///
  /// In en, this message translates to:
  /// **'Current layout'**
  String get currentLayout;

  /// No description provided for @layoutMustFinishWithDynamicBlock.
  ///
  /// In en, this message translates to:
  /// **'Your layout must finish with a dynamic block'**
  String get layoutMustFinishWithDynamicBlock;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @layoutSaved.
  ///
  /// In en, this message translates to:
  /// **'Layout saved'**
  String get layoutSaved;

  /// No description provided for @articlePreferencesExplanation.
  ///
  /// In en, this message translates to:
  /// **'This is guidance for the AI model. Telling it what kind of article you prefer to prioritize for the scoring  of each article. The change only applies to future articles.'**
  String get articlePreferencesExplanation;

  /// No description provided for @minimumNewsScore.
  ///
  /// In en, this message translates to:
  /// **'Minimum news score'**
  String get minimumNewsScore;

  /// No description provided for @minimumNewsScoreExplanation.
  ///
  /// In en, this message translates to:
  /// **'This will filter out from your feed any news that has been scored lower than the selected value'**
  String get minimumNewsScoreExplanation;

  /// No description provided for @preferenceUpdated.
  ///
  /// In en, this message translates to:
  /// **'Preferences updated'**
  String get preferenceUpdated;

  /// No description provided for @readItemHandling.
  ///
  /// In en, this message translates to:
  /// **'Read item handling'**
  String get readItemHandling;

  /// No description provided for @readItemHandlingExplanation.
  ///
  /// In en, this message translates to:
  /// **'While you scroll through the feed, items will be set as read. Select how you want to handle the read items in your feed'**
  String get readItemHandlingExplanation;

  /// No description provided for @appColor.
  ///
  /// In en, this message translates to:
  /// **'App color'**
  String get appColor;

  /// No description provided for @blackBackground.
  ///
  /// In en, this message translates to:
  /// **'Black background'**
  String get blackBackground;

  /// No description provided for @blackBackgroundExplanation.
  ///
  /// In en, this message translates to:
  /// **'Use black background for the dark theme'**
  String get blackBackgroundExplanation;

  /// No description provided for @dynamicColor.
  ///
  /// In en, this message translates to:
  /// **'Dynamic color'**
  String get dynamicColor;

  /// No description provided for @dynamicColorExplanation.
  ///
  /// In en, this message translates to:
  /// **'User device accent color'**
  String get dynamicColorExplanation;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get passwordUpdated;

  /// No description provided for @dropBlockHere.
  ///
  /// In en, this message translates to:
  /// **'Drop block here'**
  String get dropBlockHere;

  /// No description provided for @itemHandlingLabel.
  ///
  /// In en, this message translates to:
  /// **'{handling, select, none{Display normally} dim{Dim} hide{Hide} unreadFirstThenDim{Unread first then dim} other{No handling selected}}'**
  String itemHandlingLabel(String handling);

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @firstTimeSetup.
  ///
  /// In en, this message translates to:
  /// **'First time setup'**
  String get firstTimeSetup;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @setupComplete.
  ///
  /// In en, this message translates to:
  /// **'Setup complete !'**
  String get setupComplete;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Newsku!\n\nThis walkthrough will help you complete the initial configuration of the application.You can adjust any of these settings later in the Application Settings menu.'**
  String get welcomeText;

  /// No description provided for @noFeeds.
  ///
  /// In en, this message translates to:
  /// **'No feeds added, either add a feed via its url or import an OPML file'**
  String get noFeeds;

  /// No description provided for @addBlock.
  ///
  /// In en, this message translates to:
  /// **'Add block'**
  String get addBlock;

  /// No description provided for @selectBlock.
  ///
  /// In en, this message translates to:
  /// **'Select block type to add to your layout'**
  String get selectBlock;

  /// No description provided for @nErrors.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No errors} =1{1 error} other{{count} errors}}'**
  String nErrors(num count);

  /// No description provided for @duringLastRefreshAttempt.
  ///
  /// In en, this message translates to:
  /// **'During last refresh attempt'**
  String get duringLastRefreshAttempt;

  /// No description provided for @feedErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'{feedName} errors'**
  String feedErrorTitle(Object feedName);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @stackTrace.
  ///
  /// In en, this message translates to:
  /// **'Stack trace'**
  String get stackTrace;

  /// No description provided for @articleUrl.
  ///
  /// In en, this message translates to:
  /// **'Article URL'**
  String get articleUrl;

  /// No description provided for @feedRetrievalError.
  ///
  /// In en, this message translates to:
  /// **'Error while querying the RSS feed URL'**
  String get feedRetrievalError;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @buildNumber.
  ///
  /// In en, this message translates to:
  /// **'Build number'**
  String get buildNumber;

  /// No description provided for @package.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get package;

  /// No description provided for @backendVersion.
  ///
  /// In en, this message translates to:
  /// **'Backend version'**
  String get backendVersion;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Show License'**
  String get licenses;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get feedback;

  /// No description provided for @backendUrl.
  ///
  /// In en, this message translates to:
  /// **'Backend URL'**
  String get backendUrl;

  /// No description provided for @submitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Submit feedback'**
  String get submitFeedback;

  /// No description provided for @submitFeedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'Found a bug or have a suggestion? Use this tool to take screenshot of the app, annotate and submit feedback'**
  String get submitFeedbackDescription;

  /// No description provided for @feedbackDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'To submit feedback you will need a GitHub account and your screenshot will be submitted to Imgur anonymously.'**
  String get feedbackDisclaimer;

  /// No description provided for @density.
  ///
  /// In en, this message translates to:
  /// **'UI Density'**
  String get density;

  /// No description provided for @dense.
  ///
  /// In en, this message translates to:
  /// **'Dense'**
  String get dense;

  /// No description provided for @spacious.
  ///
  /// In en, this message translates to:
  /// **'Spacious'**
  String get spacious;

  /// No description provided for @deviceOnlySettings.
  ///
  /// In en, this message translates to:
  /// **'The settings in this section are saved on the device'**
  String get deviceOnlySettings;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @tagStatsExplanation.
  ///
  /// In en, this message translates to:
  /// **'This page show how many times you clicked on articles with the following tags in the last 30 days. Those stats are used when the AI model scores the importance of an article'**
  String get tagStatsExplanation;

  /// No description provided for @feedStatsExplanation.
  ///
  /// In en, this message translates to:
  /// **'This page show how many times you clicked on articles from a given feed in the last 30 days'**
  String get feedStatsExplanation;

  /// No description provided for @noStats.
  ///
  /// In en, this message translates to:
  /// **'No stats available, stats are only recorded once you click on an article in your feed'**
  String get noStats;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @invalidLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid link'**
  String get invalidLink;

  /// No description provided for @invalidLinkExplanation.
  ///
  /// In en, this message translates to:
  /// **'This reset password link is invalid. It might also be expired.'**
  String get invalidLinkExplanation;

  /// No description provided for @passwordReset.
  ///
  /// In en, this message translates to:
  /// **'Password reset'**
  String get passwordReset;

  /// No description provided for @passwordResetExplanation.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset, you can now log in with your new password'**
  String get passwordResetExplanation;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password ?'**
  String get forgotPassword;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @passwordResetRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Password reset request submitted'**
  String get passwordResetRequestSubmitted;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'{theme, select, light{Light} dark{Dark} other{Follow system}}'**
  String appTheme(String theme);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @emailDigestTitle.
  ///
  /// In en, this message translates to:
  /// **'Email digest'**
  String get emailDigestTitle;

  /// No description provided for @emailDigest.
  ///
  /// In en, this message translates to:
  /// **'{digest, select, daily{Daily} weekly{Weekly} monthly{Montly} other{{digest}}}'**
  String emailDigest(String digest);

  /// No description provided for @emailDigestExplanation.
  ///
  /// In en, this message translates to:
  /// **'Receive periodic emails with the top rated articles in the past selected period'**
  String get emailDigestExplanation;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @newEmail.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get newEmail;

  /// No description provided for @emailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Email updated'**
  String get emailUpdated;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidUrl;

  /// No description provided for @uncategorized.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorized;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @noFeedInCategory.
  ///
  /// In en, this message translates to:
  /// **'No feed in category, drag and drop them here'**
  String get noFeedInCategory;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteCategoryExplanation.
  ///
  /// In en, this message translates to:
  /// **'Deleting a category will also delete all the feeds it contains. This cannot be undone'**
  String get deleteCategoryExplanation;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @feedCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get feedCategory;

  /// No description provided for @layoutBlockCategoryExplanation.
  ///
  /// In en, this message translates to:
  /// **'This block will only display blocks of the selected category'**
  String get layoutBlockCategoryExplanation;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
