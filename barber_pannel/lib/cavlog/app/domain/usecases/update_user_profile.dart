import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserProfileUseCase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> updateUSerProfile ({
    required String uid,
    String? barberName,
    String? ventureName,
    String? phoeNumber,
    String? address,
    String? image,
    int? year,
  }) async {
    try {
      final userDocRef = _firestore.collection('barbers').doc(uid);
      final docSnapshot = await userDocRef.get();

      if (!docSnapshot.exists) {
        log('barber not found');
        return false;
      }

      final currentData = docSnapshot.data() as Map<String, dynamic>;

      final newData = {
        'barberName': barberName,
        'ventureName': ventureName,
        'phoneNumber': phoeNumber,
        'address': address,
        'image': image,
        'age': year
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
      log('message: Update profile error : $e');
      return false;
    }
  }
}