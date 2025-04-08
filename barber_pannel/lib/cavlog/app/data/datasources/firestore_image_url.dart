import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreImageService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> storeImageUrlInFirestore(String imageUrl, String barberId) async {
    try {
      await firestore.collection('barbers').doc(barberId).update({
        'image': imageUrl,
      });
      return true;
    } catch (e) {
      log('message: Error updating image URL: $e');
      return false;
    }
  }
}