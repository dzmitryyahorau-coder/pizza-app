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

  @override
  String get cartEnterDeliveryAddress => 'Ввести адресс доставки';

  @override
  String get changeButton => 'Изменить';

  @override
  String get cartUpcellSectionHead => 'Добавим в заказ?';

  @override
  String proceedToCheckoutForButton(Object price) {
    return 'Перейти к оплате $price ₽';
  }

  @override
  String get enterPromoCodePlaceholder => 'Ввести промокод';

  @override
  String positionsLabel(Object count) {
    return 'Позиций: $count';
  }

  @override
  String get loginTitle => 'Вход';

  @override
  String get emailHint => 'Email';

  @override
  String get nameHint => 'Имя';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get logoutButton => 'Выйти';

  @override
  String get registerButton => 'Создать аккаунт';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get loadingText => 'Загрузка...';

  @override
  String get errorEmptyFields => 'Поля не могут быть пустыми';

  @override
  String get errorInvalidCredentials => 'Неверный email или пароль';

  @override
  String get errorUnknown => 'Произошла непредвиденная ошибка';

  @override
  String get errorUserNotFound =>
      'Пользователь с таким email не зарегистрирован';

  @override
  String get errorTooManyRequests => 'Too much requests sent. Relax';

  @override
  String get categoryPizza => 'Пицца';

  @override
  String get categorySnacks => 'Закуски';

  @override
  String get categoryDrinks => 'Напитки';

  @override
  String get categoryDesserts => 'Десерты';

  @override
  String get categoryBreakfast => 'Завтраки';

  @override
  String get categoryCombo => 'Комбо';

  @override
  String get profileSettingsHead => 'Настройки профиля';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get permissionDeniedTitle => 'Нет доступа';

  @override
  String get permissionDeniedMessage =>
      'Вы запретили доступ. Разрешите его в настройках приложения, чтобы продолжить.';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get cancel => 'Отмена';

  @override
  String get permissionRestrictedTitle => 'Доступ ограничен';

  @override
  String get permissionRestrictedMessage =>
      'Доступ к этой функции ограничен настройками устройства, поэтому изменить его из приложения нельзя.';

  @override
  String get ok => 'ОК';

  @override
  String get cameraDenied => 'Без доступа к камере сделать фото не получится';

  @override
  String get avatarFromCamera => 'Сделать фото';

  @override
  String get avatarFromGallery => 'Выбрать из галереи';

  @override
  String get profileSaved => 'Изменения сохранены';

  @override
  String get emailVerificationSent =>
      'Мы отправили письмо на новый адрес. Перейдите по ссылке в нём, чтобы подтвердить смену email';

  @override
  String get errorEmailInUse => 'Этот email уже используется';

  @override
  String get errorInvalidEmail => 'Некорректный email';

  @override
  String get lowBatteryTitle => 'Низкий заряд батареи';

  @override
  String lowBatteryMessage(int level) {
    return 'Заряд батареи: $level%. На экранах OLED тёмная тема помогает экономить энергию. Включить её?';
  }

  @override
  String get enableDarkTheme => 'Включить тёмную тему';

  @override
  String get notNow => 'Не сейчас';
}
