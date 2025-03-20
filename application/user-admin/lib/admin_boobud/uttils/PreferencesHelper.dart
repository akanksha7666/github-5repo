
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dio/authModels/LoginModelResponse.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;

  static const emailKey = "prfEmailNameKey";
  static const loginIs = "prfLoginIs";
  static const token = "prfLoginIs";
  static const String _userDataKey = "user_data";


  /// Initialize SharedPreferences
  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a string value
  static Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  /// Get a string value
  static String? getString(String key) {
    return _preferences.getString(key);
  }

  /// Save an integer value
  static Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  /// Get an integer value
  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  /// Save a boolean value
  static Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  /// Get a boolean value
  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  /// Save a double value
  static Future<void> setDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  /// Get a double value
  static double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  /// Save a list of strings
  static Future<void> setStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  /// Get a list of strings
  static List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  /// Remove a key
  static Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  /// Clear all preferences
  static Future<void> clear() async {
    await _preferences.clear();
  }

  /// =========================================== User Details Store Hear ============================================

  /// ✅ Save Data Model to SharedPreferences
  static Future<void> saveUserData(userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(userData.toJson());
    await prefs.setString(_userDataKey, jsonData);
  }

  /// ✅ Retrieve Data Model from SharedPreferences
  static Future<Data?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(_userDataKey);

    if (jsonData != null) {
      return Data.fromJson(jsonDecode(jsonData));
    }
    return null;
  }

  /// ✅ Clear User Data from SharedPreferences
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }


}
