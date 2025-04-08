import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import 'package:user_panel/core/common/custom_hashing_class.dart';

abstract class AuthRepositoryLogin {
  Stream<UserModel?> login(String email, String password);
}

class AuthRepositoryImplLogin implements AuthRepositoryLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<UserModel?> login(String email, String password) async* {
    try {
      String hashPassword = Hashfunction.generateHash(password);
      yield* Stream.fromFuture(_auth.signInWithEmailAndPassword(email: email, password: hashPassword)).asyncMap((UserCredential userCredential) async {
          if (userCredential.user != null) {
            String uid = userCredential.user!.uid;
            DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
             
            if (userDoc.exists) {
              return UserModel.fromMap(uid, userDoc.data() as Map<String, dynamic>);
            } else {
              throw FirebaseAuthException(code: 'user-not-found', message: 'User data not found.');
            }
          }
          return null;
      });
    } on FirebaseException catch (e){
      Exception('Firebase Exception: ${e.code}');
      yield null;
      rethrow;
    }catch (e) {
      Exception('An Error Occurred: ${e.toString()}');
      yield null;
    }
  }
}
