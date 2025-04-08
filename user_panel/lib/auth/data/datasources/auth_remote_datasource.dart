import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import 'package:user_panel/core/common/custom_hashing_class.dart';

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
      String hashPassword = Hashfunction.generateHash(password);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: hashPassword);
      String uid = userCredential.user!.uid; 

      
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
       'userName': userName,
       'phoneNumber': phoneNumber,
       'address': address,
       'email': email,
       'image': image ?? '',
       'age': age ?? 0,
       'uid': uid,
       'google': false,
       'createdAt': FieldValue.serverTimestamp(),
      });
       return true;
      }else {
       return false;
      }
    } catch (e) { 
      return false;
    }
  }


  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

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
           UserModel newUser = UserModel(
            uid: user.uid, 
            userName: user.displayName ?? '', 
            phoneNumber: user.phoneNumber ?? '', 
            address: '', 
            email: user.email ?? '', 
            image: user.photoURL ?? '', 
            age: 0, 
            google: true,
            createdAt: DateTime.now());

            await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
            return newUser;
         } else {
           return UserModel.fromMap(user.uid, userDoc.data() as Map<String, dynamic>);
         }
       }
    } catch (e) {  
       log('Google sign-in Eroor: $e');
      return null;
    }
    return null;
  }
}