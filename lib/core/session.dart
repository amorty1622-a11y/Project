import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _onboardedKey = 'onboarded';

  Future<void> init() async {}

  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> setOnboarded() async {
    await _storage.write(key: _onboardedKey, value: '1');
  }

  Future<bool> isOnboarded() async {
    final v = await _storage.read(key: _onboardedKey);
    return v == '1';
  }
}

