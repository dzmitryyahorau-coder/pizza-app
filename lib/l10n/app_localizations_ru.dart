// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Пицца';

  @override
  String get showAllLabel => 'Показать все';

  @override
  String get menuHeaderDeliveryFree => 'Доставка бесплатная';

  @override
  String menuHeaderDeliveryTime(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'около $minutes минуты',
      many: 'около $minutes минут',
      few: 'около $minutes минут',
      one: 'около $minutes минуты',
    );
    return '$_temp0';
  }

  @override
  String get featuresSectionTitle => 'Выгодно и вкусно';

  @override
  String productPriceFrom(Object price) {
    return 'от $price ₽';
  }

  @override
  String productPrice(Object price) {
    return '$price ₽';
  }

  @override
  String productSizeCm(Object size) {
    return '$size см';
  }

  @override
  String get productCustomizationButtonLabel => 'Сделать вкуснее';

  @override
  String get productAddToTasteSectionTitle => 'Добавьте по вкусу';

  @override
  String itemWeightInGrams(Object weight) {
    return '$weight g';
  }

  @override
  String get deliveryAddresesScreenHead => 'Адреса доставки';

  @override
  String get addYourDeliveryAddressHead => 'Добавьте свой адрес';

  @override
  String get addYourDeliveryAddressBody => 'А мы привезем всё свежим и горячим';

  @override
  String get addAddressButton => 'Добавить адрес';

  @override
  String get notNowButton => 'Не сейчас';

  @override
  String get closeButton => 'Закрыть';
}
