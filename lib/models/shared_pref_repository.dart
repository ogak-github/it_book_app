import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  static SharedPreferences? _sprefs;

  static init() async {
    _sprefs = await SharedPreferences.getInstance();
  }

  static putBoolean(String key, bool value) {
    if (_sprefs != null) _sprefs!.setBool(key, value);
  }

  static getBoolean(String key) {
    return _sprefs == null ? false : _sprefs!.getBool(key) ?? false;
  }
}
