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
}
