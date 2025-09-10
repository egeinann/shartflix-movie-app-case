import 'package:shared_preferences/shared_preferences.dart';

class Token {
   static Future<String?> getIdToken() async {
    final  prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}