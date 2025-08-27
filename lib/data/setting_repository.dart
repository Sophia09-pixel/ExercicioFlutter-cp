import 'package:shared_preferences/shared_preferences.dart';
import 'package:exercicio_cp/model/time.dart';
import 'dart:convert';

class SettingsRepository {
  static const _keyShowTime = 'TimeSelect';
  static const _keyTime = 'SelectedTime';

  final SharedPreferences _prefs;

  SettingsRepository._(this._prefs);

  static Future<SettingsRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsRepository._(prefs);
  }

  /// Verifica se já foi selecionado algum time
  Future<bool> getTimeSelected() =>
      Future.value(_prefs.getBool(_keyShowTime) ?? false);

  /// Define se o time foi selecionado (usado para controle de introdução)
  Future<void> setShowIntro(bool value) =>
      _prefs.setBool(_keyShowTime, value);

  /// Salva o time escolhido no SharedPreferences (em formato JSON)
  Future<void> setTime(Time time) async {
    final jsonString = jsonEncode(time.toJson());
    await _prefs.setString(_keyTime, jsonString);
    await setShowIntro(true); // Marca que o time foi selecionado
  }

  /// Recupera o time salvo (ou retorna null)
  Future<Time?> getTime() async {
    final jsonString = _prefs.getString(_keyTime);
    if (jsonString == null) return null;

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return Time.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  /// Limpa o time selecionado
  Future<void> clear() async {
    await _prefs.remove(_keyTime);
    await _prefs.setBool(_keyShowTime, false);
  }
}
