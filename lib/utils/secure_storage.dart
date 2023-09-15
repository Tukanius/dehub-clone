import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyEmail = 'email';
  final String _keyCode = 'code';
  final String _keyPassWord = 'password';
  final String _isBiometric = 'biometric';

  Future setEmail(String email) async {
    await storage.write(key: _keyEmail, value: email);
  }

  Future setCode(String code) async {
    await storage.write(key: _keyCode, value: code);
  }

  Future<String?> getEmail() async {
    return await storage.read(key: _keyEmail);
  }

  Future<String?> getCode() async {
    return await storage.read(key: _keyCode);
  }

  Future deleteAll() async {
    await storage.deleteAll();
    print("ALL STORAGE DELETED");
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }

  Future setBioMetric(bool bioMetric) async {
    await storage.write(key: _isBiometric, value: "${bioMetric}");
  }

  Future<String?> getBioMetric() async {
    return await storage.read(key: _isBiometric);
  }
}
