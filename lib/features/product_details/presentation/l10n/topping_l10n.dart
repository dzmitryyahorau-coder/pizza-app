import 'package:pizza_app/l10n/app_localizations.dart';

extension ToppingL10n on AppLocalizations {
  String toppingName(String key) => switch (key) {
    'pepperoni' => toppingPepperoni,
    'pineapple' => toppingPineapple,
    'mushrooms' => toppingMushrooms,
    'cheddar_parmesan' => toppingCheddarParmesan,
    'bacon' => toppingBacon,
    _ => _humanize(key),
  };
}

String _humanize(String key) {
  final text = key.replaceAll('_', ' ');
  return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
