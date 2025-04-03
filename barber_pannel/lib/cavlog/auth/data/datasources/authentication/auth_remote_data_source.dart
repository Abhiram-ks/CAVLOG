import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpBarber({
    required String barberName,
    required String ventureName,
    required String phoneNumber,
    required String address,
    required String email,
    required String password,
    required bool isVerified,
    required bool isblok,
    String? image,
    int? age,
  }) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection('barbers')
          .where(
            'email',
            isEqualTo: email,
          ).get();

      if (emailQuery.docs.isNotEmpty) {
        log('Email already exists');
        return false;
      }
      UserCredential response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (response.user != null) {
       // await response.user!.sendEmailVerification();
        log('Verification email sent to: $email');
        await _firestore.collection('barbers').doc(response.user!.uid).set({
          'barberName': barberName,
          'ventureName': ventureName,
          'phoneNumber': phoneNumber,
          'address': address,
          'email': email,
          'isVerified': isVerified,
          'image': image ?? '',
          'age': age ?? 0,
          'isBlok': isblok,
          'Uid':response.user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        log('$barberName $ventureName $phoneNumber $address $email $isVerified');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
