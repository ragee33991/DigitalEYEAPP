import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAIL";

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        Constants.sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUerLoggedInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(Constants.sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserEmailKey);
  }

  static String makeFirstLetterUpperCase(String string) {
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  static addSundayBlurred(String sunday ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue',sunday);
  }

}