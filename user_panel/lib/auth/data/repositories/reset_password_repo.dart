import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> isEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection('users').where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isEmpty){
        return false;
      }
     final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
     if (data['google'] == true){
      return false;
     }      
      return true;
    } catch (e) {
      return false;
    }
  }


  Future<bool> sendPasswordResetEmail (String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}