import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart' show BarberServiceModel;


abstract class FetchBarberDetailsRepository {
  Stream<List<BarberServiceModel>> streamAllBarbersServices(String barberId);
} 

class FetchBarberDetailsRepositoryImpl implements FetchBarberDetailsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<BarberServiceModel>> streamAllBarbersServices(String barberId) {
     final docRef = _firestore.collection('individual_barber_services').doc(barberId);

     try {
       return docRef.snapshots().map((docSnapshot) {
         if (!docSnapshot.exists) return <BarberServiceModel>[];

         final data = docSnapshot.data();
         if (data == null || data.isEmpty || data['services'] == null) {
          return <BarberServiceModel>[];
         } 

          final servicesMap = Map<String, dynamic>.from(data['services'] as Map);

          return servicesMap.entries.map((entry) {
            return BarberServiceModel.fromMap(
              barberID: barberId, 
              key: entry.key, 
              value: entry.value);
          }).toList();
       });
     } catch (e) {
      log('Error fetching berber services: $barberId: $e');
       return Stream.value(<BarberServiceModel>[]);
     }
        
  }
}