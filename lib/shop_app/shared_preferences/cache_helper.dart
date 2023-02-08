import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences? sharedPreferences;

//init sharedPreference method__________________________________________________
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

//saveData Method_______________________________________________________________
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

//getData Method________________________________________________________________
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

//removeData Method_____________________________________________________________
  static Future<bool> removeData({
    required String key,
  }) async{
    return await sharedPreferences!.remove(key);
  }
}
