import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _key = 'theme_mode';

  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_read(_prefs));

  static ThemeMode _read(SharedPreferences prefs) {
    final saved = prefs.getString(_key);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  Future<void> setMode(ThemeMode mode) async {
    if (mode == state) return;
    emit(mode);
    await _prefs.setString(_key, mode.name);
  }

  Future<void> setDark() => setMode(ThemeMode.dark);
  Future<void> setLight() => setMode(ThemeMode.light);
  Future<void> setSystem() => setMode(ThemeMode.system);
}
