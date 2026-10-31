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
}
