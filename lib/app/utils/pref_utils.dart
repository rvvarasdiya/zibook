import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wraps the [SharedPreferences].
class PrefUtils {
  static final Logger _log = Logger("Prefs");

  SharedPreferences preferences;

  double screenSizeWidth;


  /// The [prefix] is used in keys for user specific preferences. You can use unique user-id for multi_user
  String get prefix => "my_app";

  String get keyIsShowThemeSelection => "keyIsShowThemeSelection";

  String get keySelectedThemeId => "keySelectedThemeId";

  Future<void> init() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  /// Gets the int value for the [key] if it exists.
  int getInt(String key, {int defaultValue = 0}) {
    try {
      init();
      return preferences.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the bool value for the [key] if it exists.
  bool getBool(String key, {bool defaultValue = false}) {
    try {
      init();
      return preferences.getBool(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  String getString(String key, {String defaultValue}) {
    try {
      init();
      return preferences.getString(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  List<String> getStringList(String key) {
    try {
      init();
      return preferences.getStringList(key) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Gets the int value for the [key] if it exists.
  void saveInt(String key, int value) {
    init();
    preferences.setInt(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveBoolean(String key, bool value) {
    init();
    preferences.setBool(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveString(String key, String value) {
    init();
    preferences.setString(key, value);
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  void saveStringList(String key, List<String> value) {
    init();
    preferences.setStringList(key, value);
  }

  void saveShowThemeSelection(bool showThemeSelection) {
    preferences.setBool(keyIsShowThemeSelection, showThemeSelection);
  }

  bool isUserLogin() {
    return true;
  }

  String getUserToken() {
    return "token";
  }
}
