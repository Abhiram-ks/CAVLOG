
import 'dart:developer';

import 'package:barber_pannel/cavlog/app/data/models/barberservice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreBarberService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadNewBarberService({
    required String barberID,
    required List<BarberServiceModel> services,
  }) async {
    try {
      final DocumentReference barberDoc = _firestore
          .collection('individual_barber_services')
          .doc(barberID);

      final docSnapshot = await barberDoc.get();

      Map<String, dynamic> existingServices = {};
      if (docSnapshot.exists) {
        existingServices = (docSnapshot.data() as Map<String, dynamic>?)?['services'] ?? {};
      }

      for (BarberServiceModel service in services) {
        if (existingServices.containsKey(service.serviceName)) {
          log('Duplicate service: ${service.serviceName}');
          return 'Duplicate service found: ${service.serviceName}';
        }
      }

      Map<String, dynamic> newServices = {
        for (var service in services) service.serviceName: service.amount
      };

      await barberDoc.set({
        'services': {...existingServices, ...newServices}
      }, SetOptions(merge: true));

      return null;
    } catch (e) {
      log('Error uploading service: $e');
      return 'Error uploading service: $e';
    }
  }
}
