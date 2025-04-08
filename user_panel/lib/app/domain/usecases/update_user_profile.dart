import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserProfileUseCase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> updateUSerProfile ({
    required String uid,
    String? userName,
    String? phoeNumber,
    String? address,
    String? image,
    int? age,
  }) async {
    try {
      final userDocRef = _firestore.collection('users').doc(uid);
      final docSnapshot = await userDocRef.get();

      if (!docSnapshot.exists) {
        log('User not found');
        return false;
      }

      final currentData = docSnapshot.data() as Map<String, dynamic>;

      final newData = {
        'userName': userName,
        'phoneNumber': phoeNumber,
        'address': address,
        'image': image,
        'age': age
      };

      final updatedData = <String, dynamic> {};
      newData.forEach((key, value) {
        if (value != null && value != currentData[key]) {
          updatedData[key] = value;
        }
      });

      if (updatedData.isEmpty) {
        return true;
      }

      await userDocRef.update(updatedData);
      return true;
    } catch (e) {
      log('message: Update user profile error : $e');
      return false;
    }
  }
}