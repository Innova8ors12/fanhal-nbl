import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static const themeStatus = "themeStatus";
  static const userToken = "userToken";
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }


  clearAll()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    return prefs.getBool(themeStatus) ?? false;
  }
}