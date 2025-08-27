import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const _keyShowTime = 'TimeSelect';
  final SharedPreferences _prefs;
  SettingsRepository._(this._prefs);
  static Future<SettingsRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsRepository._(prefs);
  }

  Future<bool> getTimeSelected() =>
      Future.value(_prefs.getBool(_keyShowTime) ?? true);
  Future<void> setShowIntro(bool value) => _prefs.setBool(_keyShowTime, value);
}