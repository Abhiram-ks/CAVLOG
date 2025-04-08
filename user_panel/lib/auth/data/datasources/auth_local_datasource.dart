
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService  {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> saveUserCredentials(String userId) async {
    await _storage.write(key: 'isUserLogged', value: 'true');
    await _storage.write(key: 'userId', value: userId);
  }
  
  static Future<Map<String, String?>> getUserCredentials() async{
    String? isUserLogged  = await _storage.read(key:'isUserLogged');
    String? userId = await _storage.read(key: 'userId');
    return {'isUserLogged': isUserLogged, 'userId': userId};
  }
  
  static Future<void> clearUserCredentials() async{
    await _storage.write(key: 'isUserLogged', value: 'false');
    await _storage.delete(key: 'userId');
  }
}