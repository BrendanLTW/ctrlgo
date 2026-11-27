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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @tabExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tabExplore;

  /// No description provided for @tabFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get tabFriends;

  /// No description provided for @tabSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get tabSaved;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @mainNavigation.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get mainNavigation;

  /// No description provided for @getDirections.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get getDirections;

  /// No description provided for @shareMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Share my location'**
  String get shareMyLocation;

  /// No description provided for @addSavedPlace.
  ///
  /// In en, this message translates to:
  /// **'Add a saved place'**
  String get addSavedPlace;

  /// No description provided for @locationAskTitle.
  ///
  /// In en, this message translates to:
  /// **'See where you are'**
  String get locationAskTitle;

  /// No description provided for @locationAskBody.
  ///
  /// In en, this message translates to:
  /// **'ctrlGo uses your location to show where you are and give turn-by-turn directions. It is only shared with friends when you choose.'**
  String get locationAskBody;

  /// No description provided for @locationAskContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get locationAskContinue;

  /// No description provided for @locationOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is turned off'**
  String get locationOffTitle;

  /// No description provided for @locationOffBody.
  ///
  /// In en, this message translates to:
  /// **'ctrlGo needs your location to show where you are and give turn-by-turn directions. It is only shared with friends when you choose.'**
  String get locationOffBody;

  /// No description provided for @locationSettingsPathAndroid.
  ///
  /// In en, this message translates to:
  /// **'Settings › Apps › ctrlGo › Permissions › Location › '**
  String get locationSettingsPathAndroid;

  /// No description provided for @locationSettingsValueAndroid.
  ///
  /// In en, this message translates to:
  /// **'Allow only while using the app'**
  String get locationSettingsValueAndroid;

  /// No description provided for @locationSettingsPathIos.
  ///
  /// In en, this message translates to:
  /// **'Settings › ctrlGo › Location › '**
  String get locationSettingsPathIos;

  /// No description provided for @locationSettingsValueIos.
  ///
  /// In en, this message translates to:
  /// **'While Using the App'**
  String get locationSettingsValueIos;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @searchWithoutLocation.
  ///
  /// In en, this message translates to:
  /// **'Search without location'**
  String get searchWithoutLocation;

  /// No description provided for @whereTo.
  ///
  /// In en, this message translates to:
  /// **'Where to?'**
  String get whereTo;

  /// No description provided for @voiceSearch.
  ///
  /// In en, this message translates to:
  /// **'Voice search'**
  String get voiceSearch;

  /// No description provided for @chipHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get chipHome;

  /// No description provided for @chipWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get chipWork;

  /// No description provided for @mapLayers.
  ///
  /// In en, this message translates to:
  /// **'Show traffic'**
  String get mapLayers;

  /// No description provided for @recentre.
  ///
  /// In en, this message translates to:
  /// **'Centre on your location'**
  String get recentre;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get yourLocation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search places, addresses'**
  String get searchHint;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @loadingSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Loading suggestions'**
  String get loadingSuggestions;

  /// No description provided for @noPlacesMatch.
  ///
  /// In en, this message translates to:
  /// **'No places match that'**
  String get noPlacesMatch;

  /// No description provided for @suggestionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load suggestions. Saved places still work.'**
  String get suggestionsFailed;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @placeTypeMall.
  ///
  /// In en, this message translates to:
  /// **'Shopping mall'**
  String get placeTypeMall;

  /// No description provided for @placeTypePark.
  ///
  /// In en, this message translates to:
  /// **'Park'**
  String get placeTypePark;

  /// No description provided for @placeTypeStation.
  ///
  /// In en, this message translates to:
  /// **'Station'**
  String get placeTypeStation;

  /// No description provided for @placeTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get placeTypeRestaurant;

  /// No description provided for @placeTypeCafe.
  ///
  /// In en, this message translates to:
  /// **'Café'**
  String get placeTypeCafe;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearRecents.
  ///
  /// In en, this message translates to:
  /// **'Clear recent searches'**
  String get clearRecents;

  /// No description provided for @searchEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Check the spelling, use fewer words, or search a nearby landmark or street.'**
  String get searchEmptyBody;

  /// No description provided for @tryLabel.
  ///
  /// In en, this message translates to:
  /// **'Try'**
  String get tryLabel;

  /// No description provided for @dropPin.
  ///
  /// In en, this message translates to:
  /// **'Drop a pin instead'**
  String get dropPin;

  /// No description provided for @dropPinSub.
  ///
  /// In en, this message translates to:
  /// **'Pick the spot on the map and save it'**
  String get dropPinSub;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterday;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

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
