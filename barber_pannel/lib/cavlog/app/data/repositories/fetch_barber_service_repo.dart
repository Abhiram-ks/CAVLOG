import 'dart:developer';

import 'package:barber_pannel/cavlog/app/data/models/barberservice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchBarberServiceRepository {
  Stream <List<BarberServiceModel>> fetchBarberServicesData(String barberId);
  Future<bool> deleteBarberService({
    required String barberUid,
    required String serviceKey,
  });
  Future<bool> updateBarberService({
    required String barberUid,
    required String serviceKey,
    required double serviceValue,
  });

}


class FetchBarberServiceRepositoryImpl implements FetchBarberServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<BarberServiceModel>> fetchBarberServicesData(String barberId) {
      final docRef = _firestore.collection('individual_barber_services').doc(barberId);
    try {
      return docRef.snapshots().map((docSnapshot) {
      if (!docSnapshot.exists) return [];

      final data = docSnapshot.data();
      if (data == null || data['services'] == null) return [];

      final servicesMap = Map<String, dynamic>.from(data['services']);

       return servicesMap.entries.map((entry) {
         return BarberServiceModel.fromMap(
          barberID: barberId, 
          key: entry.key, 
          value:  entry.value);
       }).toList();
    });
    } catch (e) {
      log('message: Error occured $e');
      return Stream.value([]);
    }
  }


  @override
  Future<bool> deleteBarberService({
    required String barberUid,
    required String serviceKey,
  }) async {
    final docRef = _firestore.collection('individual_barber_services').doc(barberUid);

    try {
      await docRef.update({'services.$serviceKey': FieldValue.delete()});
      return true;
    } catch (e) {
       log('❌ Error deleting service barber: $e');
      return false;
    }
  }


  @override
  Future<bool> updateBarberService({
     required String barberUid,
     required String serviceKey,
     required double serviceValue,
  }) async {
    final docRef = _firestore.collection('individual_barber_services').doc(barberUid);

    try {
      await docRef.update({
        'services.$serviceKey': serviceValue,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}