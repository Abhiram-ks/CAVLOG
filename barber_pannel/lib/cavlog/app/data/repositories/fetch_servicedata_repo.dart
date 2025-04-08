import 'dart:developer';

import 'package:barber_pannel/cavlog/app/data/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchServiceRepository {
  Stream<List<ServiceModel>> streamAllServices();
}

class ServiceRepositoryImpl implements FetchServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ServiceModel>> streamAllServices() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromMap(doc.id, doc.data());
      }).toList();
    }).handleError((e) {
      log('Error fetching service data: $e');
    });
  }
}
