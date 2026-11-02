import 'package:flutter/material.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
