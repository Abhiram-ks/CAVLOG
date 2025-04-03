import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Future<bool> signUpUser({
    required String userName,
    required String phoneNumber,
    required String address,
    required String email,
    required String password,
    String? image,
    int? age
  }) async {
    try {
      QuerySnapshot emailQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

      if(emailQuery.docs.isNotEmpty){
        log('Email alredy exists');
        return false;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
       'userName': userName,
       'phoneNumber': phoneNumber,
       'address': address,
       'email': email,
       'image': image ?? '',
       'age': age ?? 0,
       'uid': userCredential.user!.uid,
       'createdAt': FieldValue.serverTimestamp(),
      });
      log('User success fully register : $userName, $email');
       return true;
      }else {
       return false;
      }
    } catch (e) { 
      log('Error during sign-up: $e');
      return false;
    }
  }


  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return {'success': false, 'uid': null};

      final GoogleSignInAuthentication googleAuth  = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

       UserCredential userCredential = await _auth.signInWithCredential(credential);
       User? user = userCredential.user;

       if (user != null) {
         DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

         if (!userDoc.exists) {
           await _firestore.collection('users').doc(user.uid).set({
            'userName': user.displayName ?? '',
            'phoneNumber': user.phoneNumber ?? '',
            'email': user.email ?? '',
            'image': user.photoURL ?? '',
            'uid': user.uid,
            'createdAt': FieldValue.serverTimestamp(),
           });
         }
         return {'success': true, 'uid': user.uid};
       }
    } catch (e) {  
     log('Google sign-in successful');
      return {'success': false, 'uid': null};
    }
    return {'success': false, 'uid': null}; 
  }
}