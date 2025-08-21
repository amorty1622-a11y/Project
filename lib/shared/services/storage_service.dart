import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';
  static const String _isFirstTimeKey = 'isFirstTime';
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Token management
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }
  
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }
  
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
  
  // User data management
  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toString());
  }
  
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      // Parse user string back to map
      return {};
    }
    return null;
  }
  
  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
  
  // First time flag
  Future<void> setFirstTime(bool isFirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstTimeKey, isFirstTime);
  }
  
  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }
  
  // Clear all data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}