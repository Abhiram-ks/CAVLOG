import 'dart:convert';

import 'package:crypto/crypto.dart';

class Hashfunction {
  static String generateHash(String input){
    final bytes = utf8.encode(input);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
}