import 'dart:developer';

import 'package:barber_pannel/cavlog/auth/data/models/barber_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<BarberModel?> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<BarberModel?> login(String email, String password) async* {
    try {
      yield* Stream.fromFuture(_auth.signInWithEmailAndPassword(email: email, password: password)).asyncMap((UserCredential userCredential) async {
          if (userCredential.user != null) {
            String uid = userCredential.user!.uid;
            DocumentSnapshot userDoc = await _firestore.collection('barbers').doc(uid).get();

            if (userDoc.exists) {
              return BarberModel.fromMap(uid, userDoc.data() as Map<String, dynamic>);
            } else {
              throw FirebaseAuthException(code: 'user-not-found', message: 'User data not found.');
            }
          }
          return null;
      });
    } on FirebaseException catch (e){
      log('FirebaseAuthException: ${e.message}');
      yield null;
      rethrow;
    }catch (e) {
       log('An Error Occurred Login: ${e.toString()}');
      yield null;
    }
  }
}