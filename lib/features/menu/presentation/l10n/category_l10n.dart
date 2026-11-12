import 'package:flutter/material.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

extension CategoryKeyL10N on String {
  String categoryLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (this) {
      case 'pizza':
        return l10n.categoryPizza;
      case 'snacks':
        return l10n.categorySnacks;
      case 'breakfast':
        return l10n.categoryBreakfast;
      case 'combo':
        return l10n.categoryCombo;
      case 'deserts':
        return l10n.categoryDesserts;
      case 'drink':
        return l10n.categoryDrinks;

      default:
        return this;
    }
  }
}
