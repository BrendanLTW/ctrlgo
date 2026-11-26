// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabExplore => 'Explore';

  @override
  String get tabFriends => 'Friends';

  @override
  String get tabSaved => 'Saved';

  @override
  String get tabProfile => 'Profile';

  @override
  String get mainNavigation => 'Main';

  @override
  String get getDirections => 'Get directions';

  @override
  String get shareMyLocation => 'Share my location';

  @override
  String get addSavedPlace => 'Add a saved place';

  @override
  String get locationAskTitle => 'See where you are';

  @override
  String get locationAskBody =>
      'ctrlGo uses your location to show where you are and give turn-by-turn directions. It is only shared with friends when you choose.';

  @override
  String get locationAskContinue => 'Continue';

  @override
  String get locationOffTitle => 'Location is turned off';

  @override
  String get locationOffBody =>
      'ctrlGo needs your location to show where you are and give turn-by-turn directions. It is only shared with friends when you choose.';

  @override
  String get locationSettingsPathAndroid =>
      'Settings › Apps › ctrlGo › Permissions › Location › ';

  @override
  String get locationSettingsValueAndroid => 'Allow only while using the app';

  @override
  String get locationSettingsPathIos => 'Settings › ctrlGo › Location › ';

  @override
  String get locationSettingsValueIos => 'While Using the App';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get searchWithoutLocation => 'Search without location';
}
