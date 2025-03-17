import 'dart:developer';

import 'package:barber_pannel/data/models/barber_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<BarberModel?> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<BarberModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
       
      if(userCredential.user != null){
        String uid = userCredential.user!.uid;
        DocumentSnapshot userDoc = await _firestore.collection('barbers').doc(uid).get();

        if(userDoc.exists){
          return BarberModel.fromMap(uid, userDoc.data() as Map<String, dynamic>);
        }else{
         throw FirebaseAuthException(
              code: 'user-not-found', message: 'User data not found.');
        }
      }

    }on FirebaseException catch(e){
      log('FirebaseAuthException: ${e.message}');
      throw e;
    }catch (e){
      log('An Error Occured Login : ${e.toString()}');
    }
    return null;
  }
}