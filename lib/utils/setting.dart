import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static bool get isOnbordingShow =>
      _prefsInstance?.getBool("isOnbordingShow") ?? true;
  static set isOnbordingShow(bool value) =>
      _prefsInstance?.setBool("isOnbordingShow", value);

  static String get email => _prefsInstance?.getString("email") ?? "";
  static set email(String value) => _prefsInstance?.setString("email", value);

  static String get password => _prefsInstance?.getString("password") ?? "";
  static set password(String value) =>
      _prefsInstance?.setString("password", value);

  static bool get rememberMe => _prefsInstance?.getBool("rememberMe") ?? true;
  static set rememberMe(bool value) =>
      _prefsInstance?.setBool("rememberMe", value);

  static bool get biometricEnabled =>
      _prefsInstance?.getBool("biometric_enabled") ?? true;
  static set biometricEnabled(bool value) =>
      _prefsInstance?.setBool("biometric_enabled", value);

  static Future<void> clearStorage() async {
    bool rememberMe = Storage.rememberMe;
    bool isOnbordingShow = Storage.isOnbordingShow;
    String loginEmail = "";
    String loginPassword = "";

    if (rememberMe) {
      loginEmail = Storage.email;
      loginPassword = Storage.password;
    }

    await Storage._prefsInstance?.clear();

    Storage.isOnbordingShow = isOnbordingShow;
    Storage.email = loginEmail;
    Storage.password = loginPassword;
  }
}
