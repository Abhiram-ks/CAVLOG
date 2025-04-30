import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/data/models/admin_service_model.dart';

abstract class FetchServiceRepository {
  Stream<List<AdminServiceModel>> streamAllServices();
}

class ServiceRepositoryImpl implements FetchServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<AdminServiceModel>> streamAllServices() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AdminServiceModel.fromMap(doc.id, doc.data());
      }).toList();
    }).handleError((e) {
      log('Error fetching service data: $e');
    });
  }
}
