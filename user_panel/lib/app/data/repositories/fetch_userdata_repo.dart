import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/auth/data/models/user_model.dart';

abstract class FetchUserRepository {
  Stream<UserModel?> streamUserData (String userUid);
}

class FetchUserRepositoryImpl implements FetchUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<UserModel?> streamUserData(String userUid) {
    return _firestore
    .collection('users')
    .doc(userUid)
    .snapshots()
    .map((snapshot) {
      if (snapshot.exists) {
        try {
          return UserModel.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
        } catch (e) {
          log('message: Error parsing user data: $e');
          return null;
        }
      }
      return null;
    })
    .handleError((e){
      log('Error fetching user Data: $e');
    });
  }
}