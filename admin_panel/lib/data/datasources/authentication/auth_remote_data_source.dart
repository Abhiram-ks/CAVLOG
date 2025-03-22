import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class AuthRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  String hashPassword(String password){
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> storeAdminCredentials()async{
     try {
       String hashedPassword  = hashPassword("admin@1234");

       await _firestore.collection('admin').doc('credentials').set({
        'email': 'admin@gmail.com',
        'password': hashedPassword,
       });

       log("Credentials stored successfully");
     } catch (e) {
       log("Error storing credentials: $e");
     }
  }
}