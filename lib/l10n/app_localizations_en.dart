// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pizza App';

  @override
  String get showAllLabel => 'Show all';

  @override
  String get menuHeaderDeliveryFree => 'Free delivery';

  @override
  String menuHeaderDeliveryTime(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'about $minutes minutes',
      one: 'about $minutes minute',
    );
    return '$_temp0';
  }

  @override
  String get featuresSectionTitle => 'Featured';

  @override
  String productPriceFrom(Object price) {
    return 'from $price \$';
  }

  @override
  String productPrice(Object price) {
    return '$price \$';
  }

  @override
  String productSizeCm(Object size) {
    return '$size cm';
  }

  @override
  String get productCustomizationButtonLabel => 'Customize recipe';

  @override
  String get productAddToTasteSectionTitle => 'Add to your taste';

  @override
  String itemWeightInGrams(Object weight) {
    return '$weight g';
  }

  @override
  String get deliveryAddresesScreenHead => 'Delivery addresses';

  @override
  String get addYourDeliveryAddressHead => 'Add your address';

  @override
  String get addYourDeliveryAddressBody =>
      'We\'ll deliver your order fresh and hot';

  @override
  String get addAddressButton => 'Add address';

  @override
  String get notNowButton => 'Not now';

  @override
  String get closeButton => 'Close';

  @override
  String get cartEnterDeliveryAddress => 'Enter delivery address';

  @override
  String get changeButton => 'Change';

  @override
  String get cartUpcellSectionHead => 'Add it to your order?';

  @override
  String proceedToCheckoutForButton(Object price) {
    return 'Proceed to checkout for $price \$';
  }

  @override
  String get enterPromoCodePlaceholder => 'Enter promo code';

  @override
  String positionsLabel(Object count) {
    return 'Items: $count';
  }

  @override
  String get loginTitle => 'Login';

  @override
  String get emailHint => 'Email';

  @override
  String get nameHint => 'Name';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get logoutButton => 'Log Out';

  @override
  String get registerButton => 'Sign Up';

  @override
  String get registerTitle => 'Sign Up';

  @override
  String get loadingText => 'Loading...';

  @override
  String get errorEmptyFields => 'Fields cannot be empty';

  @override
  String get errorInvalidCredentials => 'Invalid email or password';

  @override
  String get errorUnknown => 'An unexpected error occurred';

  @override
  String get errorUserNotFound => 'An user with such credentials is not found';

  @override
  String get errorTooManyRequests => 'Too much requests sent. Relax';

  @override
  String get categoryPizza => 'Pizza';

  @override
  String get categorySnacks => 'Snacks';

  @override
  String get categoryDrinks => 'Drinks';

  @override
  String get categoryDesserts => 'Desserts';

  @override
  String get categoryBreakfast => 'Breackfasts';

  @override
  String get categoryCombo => 'Combo';

  @override
  String get profileSettingsHead => 'Profile Settings';

  @override
  String get saveButton => 'Save';

  @override
  String get permissionDeniedTitle => 'No access';

  @override
  String get permissionDeniedMessage =>
      'You have denied access. Allow it in the app settings to continue.';

  @override
  String get openSettings => 'Open settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get permissionRestrictedTitle => 'Access restricted';

  @override
  String get permissionRestrictedMessage =>
      'Access to this feature is restricted by your device settings, so it can\'t be changed from the app.';

  @override
  String get ok => 'OK';

  @override
  String get cameraDenied => 'You can\'t take a photo without camera access';

  @override
  String get avatarFromCamera => 'Take a photo';

  @override
  String get avatarFromGallery => 'Choose from gallery';

  @override
  String get profileSaved => 'Changes saved';

  @override
  String get emailVerificationSent =>
      'We sent an email to your new address. Follow the link in it to confirm the change';

  @override
  String get errorEmailInUse => 'This email is already in use';

  @override
  String get errorInvalidEmail => 'Invalid email';

  @override
  String get lowBatteryTitle => 'Low battery';

  @override
  String lowBatteryMessage(int level) {
    return 'Battery level: $level%. On OLED screens, dark theme helps save power. Turn it on?';
  }

  @override
  String get enableDarkTheme => 'Enable dark theme';

  @override
  String get notNow => 'Not now';
}
