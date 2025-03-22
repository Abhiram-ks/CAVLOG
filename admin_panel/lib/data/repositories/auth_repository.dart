import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

abstract class AuthRepository {
  Future<bool> verifyAdminCredentials(String email, String password);
}

class AuthnticationProcess implements AuthRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _hashPassword(String password){
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<bool> verifyAdminCredentials(String email, String password)async{
   
   try {
     DocumentSnapshot adminDoc = await _firestore.collection('admin').doc('credentials').get();

     if(adminDoc.exists){
      String storedEmail = adminDoc['email'];
      String storedHashedPassword = adminDoc['password'];
      
      log('Admin login process: $storedEmail == $email && $storedHashedPassword == ${_hashPassword(password)} is correct');

      if (email == storedEmail && _hashPassword(password) == storedHashedPassword) {
        return true;
      }else{
        return false;
      }
     }
     return false;
   } catch (e) {
     log('Error verifying credenials: $e');
     return false;
   }
  }
}