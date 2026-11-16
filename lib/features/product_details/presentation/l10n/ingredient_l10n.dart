import 'package:pizza_app/l10n/app_localizations.dart';

extension IngredientL10n on AppLocalizations {
  String ingredientName(String key) => switch (key) {
    'tomatoes' => ingredientTomatoes,
    'mozzarella' => ingredientMozzarella,
    'tomato_sauce' => ingredientTomatoSauce,
    'sweet_pepper' => ingredientSweetPepper,
    'red_onion' => ingredientRedOnion,
    _ => _humanize(key),
  };
}

String _humanize(String key) {
  final text = key.replaceAll('_', ' ');
  return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
