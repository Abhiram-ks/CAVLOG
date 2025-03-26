import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreImageService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> selectionSlot(String imageUrl, int index) async {
    try {
      final List<String> docIds = [];
      if (index == 1) {
        docIds.add('user_doc');
      } else if (index == 2) {
        docIds.add('barber_doc');
      } else if (index == 3) {
        docIds.addAll(['user_doc', 'barber_doc']);
      } else {
        log("Invalid index: $index");
        return false;
      }
      for (String docId in docIds) {
        final success = await storeImageUrlInFirestore(imageUrl, docId);
        if (!success) {
          log("Failed to store image URL in $docId");
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Error in selectionSlot: $e");
      return false;
    }
  }
  Future<bool> storeImageUrlInFirestore(String imageUrl, String docId) async {
    try {
      final docRef = firestore.collection('banner_images').doc(docId);
      await docRef.set({
        'image_urls': FieldValue.arrayUnion([imageUrl]),
      }, SetOptions(merge: true));
      log("Image URL stored successfully in 'banner_images/$docId'");
      return true;
    } catch (e) {
      log("Error storing image URL in Firestore: $e");
      return false;
    }
  }
}
