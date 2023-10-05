import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  Application._privated();
  static final instance = Application._privated();
  //
  static late SharedPreferences _pref;
  static String token = '';
  static bool get isLogin => token.isNotEmpty;

  //
  static User? user;
  static String googleApiKey ='AIzaSyDg1evvc68xACuU2RsbBiV5uoF0vwVNM8Y';
  //

  //
  static Future initApp() async {
    _pref = await SharedPreferences.getInstance();
    token = _pref.getString('token') ?? '';
  }

  static void clear() {
    token = '';
    _pref.setString('token', '');
  }

  static bool saveKey(String key, dynamic value) {
    if (value is String) {
      _pref.setString(key, value);
    } else if (value is bool) {
      _pref.setBool(key, value);
    } else if (value is double) {
      _pref.setDouble(key, value);
    } else if (value is List<String>) {
      _pref.setStringList(key, value);
    } else if (value is int) {
      _pref.setInt(key, value);
    } else {
      return false;
    }
    return true;
  }

  static dynamic getKey(String key) {
    return _pref.get(key);
  }
}
