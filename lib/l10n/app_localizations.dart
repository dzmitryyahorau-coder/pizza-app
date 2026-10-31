import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pizza App'**
  String get appTitle;

  /// No description provided for @showAllLabel.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAllLabel;

  /// No description provided for @menuHeaderDeliveryFree.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get menuHeaderDeliveryFree;

  /// Estimated delivery time, shown next to the free delivery label
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, one{about {minutes} minute} other{about {minutes} minutes}}'**
  String menuHeaderDeliveryTime(int minutes);

  /// No description provided for @featuresSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featuresSectionTitle;

  /// No description provided for @productPriceFrom.
  ///
  /// In en, this message translates to:
  /// **'from {price} \$'**
  String productPriceFrom(Object price);

  /// No description provided for @productPrice.
  ///
  /// In en, this message translates to:
  /// **'{price} \$'**
  String productPrice(Object price);

  /// No description provided for @productSizeCm.
  ///
  /// In en, this message translates to:
  /// **'{size} cm'**
  String productSizeCm(Object size);

  /// No description provided for @productCustomizationButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Customize recipe'**
  String get productCustomizationButtonLabel;

  /// No description provided for @productAddToTasteSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to your taste'**
  String get productAddToTasteSectionTitle;

  /// No description provided for @itemWeightInGrams.
  ///
  /// In en, this message translates to:
  /// **'{weight} g'**
  String itemWeightInGrams(Object weight);

  /// No description provided for @deliveryAddresesScreenHead.
  ///
  /// In en, this message translates to:
  /// **'Delivery addresses'**
  String get deliveryAddresesScreenHead;

  /// No description provided for @addYourDeliveryAddressHead.
  ///
  /// In en, this message translates to:
  /// **'Add your address'**
  String get addYourDeliveryAddressHead;

  /// No description provided for @addYourDeliveryAddressBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll deliver your order fresh and hot'**
  String get addYourDeliveryAddressBody;

  /// No description provided for @addAddressButton.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddressButton;

  /// No description provided for @notNowButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNowButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
