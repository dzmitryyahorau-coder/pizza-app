import 'package:pizza_app/l10n/app_localizations.dart';

extension DoughL10n on AppLocalizations {
  String doughName(String key) => switch (key) {
    'thin' => doughThin,
    'traditional' => doughTraditional,
    _ => _humanize(key),
  };
}

String _humanize(String key) {
  final text = key.replaceAll('_', ' ');
  return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
