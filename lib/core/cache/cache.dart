import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String PHONE = "phone";
  static const String ID = "id";
  static const String SESSION_ID = "session_id";
  static const String TIMESTAMP = "timestamp";
  static const String TOKEN = "spavation_token";
  static const String PASSWORD = 'password';
  static const String FIRSTNAME = "first_name";
  static const String LANGUAGE = "app_language";
  static const String SHOW_RATING = "rating";

  static SharedPreferences? _prefs;
  static Map<String, dynamic> memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static void setString(String key, String value) {
    _prefs!.setString(key, value);
    memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    _prefs!.setInt(key, value);
    memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs!.setDouble(key, value);
    memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs!.setBool(key, value);
    memoryPrefs[key] = value;
  }

  static String? getString(String key, {String? def}) {
    String? val;
    if (memoryPrefs.containsKey(key)) {
      val = memoryPrefs[key];
    }
    val ??= _prefs!.getString(key);
    val ??= def;
    memoryPrefs[key] = val;
    return val;
  }

  static int? getInt(String key, {int? def}) {
    int? val;
    if (memoryPrefs.containsKey(key)) {
      val = memoryPrefs[key];
    }
    val ??= _prefs!.getInt(key);
    val ??= def;
    memoryPrefs[key] = val;
    return val;
  }

  static double? getDouble(String key, {double? def}) {
    double? val;
    if (memoryPrefs.containsKey(key)) {
      val = memoryPrefs[key];
    }
    val ??= _prefs!.getDouble(key);
    val ??= def;
    memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool? val;
    if (memoryPrefs.containsKey(key)) {
      val = memoryPrefs[key];
    }
    val ??= _prefs!.getBool(key);
    val ??= def;
    memoryPrefs[key] = val;
    return val;
  }

  static String? getPhone() {
    return getString(PHONE);
  }

  static Future<void> clear() {
    memoryPrefs.clear();
    return _prefs!.clear();
  }
}
