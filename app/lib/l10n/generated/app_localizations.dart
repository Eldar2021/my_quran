import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('id'),
    Locale('kk'),
    Locale('ky'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @myQuran.
  ///
  /// In en, this message translates to:
  /// **'MY QURAN'**
  String get myQuran;

  /// No description provided for @customizingApp.
  ///
  /// In en, this message translates to:
  /// **'Customizing app'**
  String get customizingApp;

  /// No description provided for @pleaseSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please select language'**
  String get pleaseSelectLanguage;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get pleaseSelectGender;

  /// No description provided for @selectGenderForPersonalization.
  ///
  /// In en, this message translates to:
  /// **'Select your gender to personalize main\nsettings of the app\'s content for you'**
  String get selectGenderForPersonalization;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a guest'**
  String get continueAsGuest;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @enter4DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit code\nsent to your email'**
  String get enter4DigitCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get needHelp;

  /// No description provided for @incorrectVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect verification code'**
  String get incorrectVerificationCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Assalamu alaykum'**
  String get hello;

  /// No description provided for @newUpdates.
  ///
  /// In en, this message translates to:
  /// **'New updates'**
  String get newUpdates;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @zuhr.
  ///
  /// In en, this message translates to:
  /// **'Zuhr'**
  String get zuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isya.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isya;

  /// No description provided for @azaanAlarm.
  ///
  /// In en, this message translates to:
  /// **'Azaan Alarm'**
  String get azaanAlarm;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @joinChallenge.
  ///
  /// In en, this message translates to:
  /// **'Join challenge'**
  String get joinChallenge;

  /// No description provided for @joinToHatim.
  ///
  /// In en, this message translates to:
  /// **'Join to Hatim'**
  String get joinToHatim;

  /// No description provided for @totalHatims.
  ///
  /// In en, this message translates to:
  /// **'Total\nHatims'**
  String get totalHatims;

  /// No description provided for @totalPages.
  ///
  /// In en, this message translates to:
  /// **'Total pages'**
  String get totalPages;

  /// No description provided for @yourPages.
  ///
  /// In en, this message translates to:
  /// **'Your pages'**
  String get yourPages;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get listening;

  /// No description provided for @hatim.
  ///
  /// In en, this message translates to:
  /// **'Hatim'**
  String get hatim;

  /// No description provided for @juz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juz;

  /// No description provided for @readed.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get readed;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @selectBelowPages.
  ///
  /// In en, this message translates to:
  /// **'Select below the pages that no one\nhas taken yet. Please complete\nas soon as possible'**
  String get selectBelowPages;

  /// No description provided for @juzas.
  ///
  /// In en, this message translates to:
  /// **'Juzas'**
  String get juzas;

  /// No description provided for @surahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahs;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @amen.
  ///
  /// In en, this message translates to:
  /// **'Amen'**
  String get amen;

  /// No description provided for @dua.
  ///
  /// In en, this message translates to:
  /// **'O Allah! Make the Qur’an\nmy guide, light and mercy!'**
  String get dua;

  /// No description provided for @ameen.
  ///
  /// In en, this message translates to:
  /// **'Ameen'**
  String get ameen;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @verticalSpace.
  ///
  /// In en, this message translates to:
  /// **'Vertical space'**
  String get verticalSpace;

  /// No description provided for @horizontalSpace.
  ///
  /// In en, this message translates to:
  /// **'Horizontal space'**
  String get horizontalSpace;

  /// No description provided for @screenTheme.
  ///
  /// In en, this message translates to:
  /// **'Screen theme'**
  String get screenTheme;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @transcription.
  ///
  /// In en, this message translates to:
  /// **'Transcription'**
  String get transcription;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get fontFamily;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @installed.
  ///
  /// In en, this message translates to:
  /// **'Installed'**
  String get installed;

  /// No description provided for @generalMenu.
  ///
  /// In en, this message translates to:
  /// **'General menu'**
  String get generalMenu;

  /// No description provided for @customApp.
  ///
  /// In en, this message translates to:
  /// **'Custom app'**
  String get customApp;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @forDevelopers.
  ///
  /// In en, this message translates to:
  /// **'For developers'**
  String get forDevelopers;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orange;

  /// No description provided for @blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blue;

  /// No description provided for @prophetLegacy.
  ///
  /// In en, this message translates to:
  /// **'The greatest legacy left to us by the Prophet Muhammad Mustafa (peace and blessings be upon Him) is the Quran. In our time, when Muslims are on one side, and the Quran is on the other, we decided to invite all our brothers to the wonderful world of the Holy Quran, and earn many rewards. O Muslims! \"And hold firmly to the rope of Allah and do not be divided!\"'**
  String get prophetLegacy;

  /// No description provided for @alImran.
  ///
  /// In en, this message translates to:
  /// **'( Al-Imran 103)'**
  String get alImran;

  /// No description provided for @assalamuAlaikum.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum, dear user!'**
  String get assalamuAlaikum;

  /// No description provided for @feedbackMessage.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this application you are using or if you have any suggestions to improve this application, please feel free to write your opinion about one of the following contacts below. We greatly appreciate your valuable feedback!'**
  String get feedbackMessage;

  /// No description provided for @withRespect.
  ///
  /// In en, this message translates to:
  /// **'With deep respect,\nMy Quran team!'**
  String get withRespect;

  /// No description provided for @contactVia.
  ///
  /// In en, this message translates to:
  /// **'Contact via'**
  String get contactVia;

  /// No description provided for @chatOnWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Chat on WhatsApp'**
  String get chatOnWhatsApp;

  /// No description provided for @whatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsApp;

  /// No description provided for @connectOnTelegram.
  ///
  /// In en, this message translates to:
  /// **'Connect on Telegram'**
  String get connectOnTelegram;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @contactViaEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact via Email'**
  String get contactViaEmail;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @githubMessage.
  ///
  /// In en, this message translates to:
  /// **'If you\'ve noticed any technical flaws in our app, or if you have interesting ideas for adding new features to the app, we\'re always happy to hear from you! Get in touch with us on GitHub. Please don\'t be shy! We are very interested in developing this app together.'**
  String get githubMessage;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// No description provided for @yesLogout.
  ///
  /// In en, this message translates to:
  /// **'Yes, logout'**
  String get yesLogout;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to\ndelete this account?'**
  String get confirmDeleteAccount;

  /// No description provided for @confirmDeleteAccountAlt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this account?'**
  String get confirmDeleteAccountAlt;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yesDelete;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @appUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'App update available'**
  String get appUpdateAvailable;

  /// No description provided for @newVersionRequired.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. You need to update it to continue.'**
  String get newVersionRequired;

  /// No description provided for @newVersionAvailable.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available.'**
  String get newVersionAvailable;

  /// No description provided for @remindMeLater.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get remindMeLater;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @featureInFuture.
  ///
  /// In en, this message translates to:
  /// **'This feature will be added in future versions.'**
  String get featureInFuture;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// No description provided for @tryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get tryAgainLater;

  /// No description provided for @enableDevMode.
  ///
  /// In en, this message translates to:
  /// **'Enable dev-mode'**
  String get enableDevMode;

  /// No description provided for @disableDevMode.
  ///
  /// In en, this message translates to:
  /// **'Disable dev-mode'**
  String get disableDevMode;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @testCrashlyticsAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Test Crashlytics and Analytics'**
  String get testCrashlyticsAnalytics;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'If you find our app useful, let others know by sharing it'**
  String get shareApp;

  /// No description provided for @enterVerificationCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter the full verification code.'**
  String get enterVerificationCodeValidation;

  /// No description provided for @restartApp.
  ///
  /// In en, this message translates to:
  /// **'You need to restart the app'**
  String get restartApp;

  /// No description provided for @restartForDevMode.
  ///
  /// In en, this message translates to:
  /// **'Restart application for enabling/disabling dev-mode'**
  String get restartForDevMode;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @newLocationDetected.
  ///
  /// In en, this message translates to:
  /// **'New location detected!'**
  String get newLocationDetected;

  /// No description provided for @doYouWantToChange.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change?'**
  String get doYouWantToChange;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'id', 'kk', 'ky', 'ru', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'kk':
      return AppLocalizationsKk();
    case 'ky':
      return AppLocalizationsKy();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
