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
      QuerySnapshot query = await _firestore
      .collection('barbers')
      .where('barberName', isEqualTo: barberName,)
      .get();
      
      if (query.docs.isNotEmpty) {
        log('Barber Name already exists');
        return false;
      }
      
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (response.user != null) {
        await response.user!.sendEmailVerification();
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
         'isBlok':isblok
        });
        log('$barberName $ventureName $phoneNumber $address $email $isVerified');
        return true;
      } else {
        log(response.user.toString());
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  // Future<bool> isEmailVerified() async {
  //   User? user = _auth.currentUser;
  //   if(user != null){
  //   await user.reload();
  //   return user.emailVerified;
  //   }
  //   return false;
  // }

  // Future<void> sendEmailVerification() async{
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //   }
  // }
}

