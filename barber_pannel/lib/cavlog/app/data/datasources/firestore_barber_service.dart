import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreBarberService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadNewBarberService({
    required String barberID,
    required String services,  
    required double serviceRate, 
  }) async {
    try {
      final DocumentReference barberDoc = _firestore.collection('individual_barber_services')
          .doc(barberID);

      final docSnapshot = await barberDoc.get();

      Map<String, dynamic> existingServices = {};
      if (docSnapshot.exists) {
        existingServices = ((docSnapshot.data() as Map<String, dynamic>?)?['services'] ?? {}) as Map<String, dynamic>;
      }

      if (existingServices.containsKey(services)) {
        return 'Duplicate service found: $services';
      }
      
      await barberDoc.set({
        'services': {
          services: serviceRate,
        }
      }, SetOptions(merge: true));

      return null;
    } catch (e) {
      return 'Error uploading service: $e';
    }
  }


  Future<bool> uploadNewFirebaseBarberFileds({
    required String barberID,
    required String imageUrl,
    required String gender,
  }) async {
    try {
      final barberRef = _firestore.collection('barbers').doc(barberID);
      await barberRef.update({
        'DetailImage': imageUrl,
        'gender': gender,
      });
      return true;
    } catch (e) {
      log('Error updating barber fields: $e');
      return false;
    }
  }
}
