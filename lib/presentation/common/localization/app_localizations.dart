import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Flutter MVC'**
  String get app_title;

  /// No description provided for @movie_title.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movie_title;

  /// No description provided for @artists_title.
  ///
  /// In en, this message translates to:
  /// **'Artists'**
  String get artists_title;

  /// No description provided for @about_title.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about_title;

  /// No description provided for @about_description.
  ///
  /// In en, this message translates to:
  /// **'Flutter BLoC MVC Example Project.\n\nDeveloped in {lang} following the {cleanArch} principles by Carlos Guillen.'**
  String about_description(Object cleanArch, Object lang);

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @sign_in_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get sign_in_welcome_title;

  /// No description provided for @sign_in_welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your user data to continue'**
  String get sign_in_welcome_subtitle;

  /// No description provided for @sign_in_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get sign_in_username;

  /// No description provided for @sign_in_username_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get sign_in_username_hint;

  /// No description provided for @sign_in_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get sign_in_password;

  /// No description provided for @sign_in_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get sign_in_password_hint;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get sign_out;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_title;

  /// No description provided for @error_default.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred.'**
  String get error_default;

  /// No description provided for @error_timeout.
  ///
  /// In en, this message translates to:
  /// **'We are experiencing some temporary problems. Please, try again in a few moments.'**
  String get error_timeout;

  /// No description provided for @error_no_internet.
  ///
  /// In en, this message translates to:
  /// **'There is no Internet connection. Check your Wi-Fi or mobile data connection, please.'**
  String get error_no_internet;

  /// No description provided for @error_server.
  ///
  /// In en, this message translates to:
  /// **'We are experiencing some problems at this time. Please come back later.'**
  String get error_server;

  /// No description provided for @error_empty_field.
  ///
  /// In en, this message translates to:
  /// **'This field can not be empty'**
  String get error_empty_field;

  /// No description provided for @action_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get action_ok;

  /// No description provided for @action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get action_cancel;

  /// No description provided for @action_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get action_retry;

  /// No description provided for @floating_button_movie.
  ///
  /// In en, this message translates to:
  /// **'Watch movie'**
  String get floating_button_movie;

  /// No description provided for @floating_button_tv.
  ///
  /// In en, this message translates to:
  /// **'Watch serie'**
  String get floating_button_tv;

  /// No description provided for @vote_movie.
  ///
  /// In en, this message translates to:
  /// **'Vote this movie'**
  String get vote_movie;

  /// No description provided for @vote_tv.
  ///
  /// In en, this message translates to:
  /// **'Vote this serie'**
  String get vote_tv;

  /// No description provided for @episode.
  ///
  /// In en, this message translates to:
  /// **'Episodes:'**
  String get episode;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'no description available'**
  String get no_description;

  /// No description provided for @last_episode.
  ///
  /// In en, this message translates to:
  /// **'Last episode'**
  String get last_episode;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @nets.
  ///
  /// In en, this message translates to:
  /// **'Nets'**
  String get nets;

  /// No description provided for @last_searchs.
  ///
  /// In en, this message translates to:
  /// **'Your last searches'**
  String get last_searchs;

  /// No description provided for @name_a_movie.
  ///
  /// In en, this message translates to:
  /// **'Name a movie'**
  String get name_a_movie;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @seasons.
  ///
  /// In en, this message translates to:
  /// **'Seasons'**
  String get seasons;

  /// No description provided for @casting.
  ///
  /// In en, this message translates to:
  /// **'Casting'**
  String get casting;

  /// No description provided for @popular_movies.
  ///
  /// In en, this message translates to:
  /// **'Popular movies'**
  String get popular_movies;

  /// No description provided for @toprated_movies.
  ///
  /// In en, this message translates to:
  /// **'Top Rated movies'**
  String get toprated_movies;

  /// No description provided for @toprated_tv.
  ///
  /// In en, this message translates to:
  /// **'Top Rated series'**
  String get toprated_tv;

  /// No description provided for @popular_tv.
  ///
  /// In en, this message translates to:
  /// **'Popular series'**
  String get popular_tv;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Production companies'**
  String get product;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming movies'**
  String get upcoming;

  /// No description provided for @release_date.
  ///
  /// In en, this message translates to:
  /// **'Release date:'**
  String get release_date;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
