import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isEmailExists(String email) async{
    try {
      QuerySnapshot emailQuery = await _firestore
      .collection('barbers')
      .where('email', isEqualTo: email)
      .get();

      return emailQuery.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking email: $e');
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending reset email $e');
    }
  }

}