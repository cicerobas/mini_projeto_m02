import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDatasource {
  Future<void> saveUser(Map<String, dynamic> user);
  Future<Map<String, dynamic>?> getUser();
  Future<void> clearUser();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const _loggedUserKey = "logged_user";

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedUserKey, jsonEncode(user));
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(_loggedUserKey);
    if (user != null) {
      return jsonDecode(user) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedUserKey);
  }
}
