import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {

  static const _storage = FlutterSecureStorage();
  static const _keyUser = 'username';
  static const _keyPasswd = 'password';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUser, value: username);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUser);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPasswd, value: password);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPasswd);

  static Future deleteUsername() async =>
      await _storage.deleteAll();
  }
