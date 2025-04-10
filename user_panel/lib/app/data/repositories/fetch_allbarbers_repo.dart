import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/barber_model.dart' show BarberModel;

abstract class FetchBarberRepository {
  Stream<List<BarberModel>> streamAllBarbers();
}

class FetchBarberRepositoryImpl implements FetchBarberRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<BarberModel>> streamAllBarbers() {
    return _firestore
        .collection('barbers')
        .orderBy('ventureName')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            try {
              return BarberModel.fromMap(doc.id, doc.data());
            } catch (e) {
              log('Error parsing barber: $e');
              return null;
            }
          }).whereType<BarberModel>().toList();
        })
        .handleError((e) {
          log('Error fetching all barbers: $e');
        });
  }
}