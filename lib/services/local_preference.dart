import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static const themeCode = "themeCode";
  static const userToken = "userToken";
  static const userEmail = "userEmail";
  setTheme(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(themeCode, code);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    return prefs.getString(themeCode) ?? "ps";
  }

  setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userToken, token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    return prefs.getString(userToken) ?? "null";
  }

  setUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userEmail, email);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    return prefs.getString(userEmail) ?? "null";
  }
}
