import 'dart:developer';

import 'package:barber_pannel/cavlog/auth/data/models/barber_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class 
FetchBarberRepository {
  Stream<BarberModel?> streamBarberData(String barberUid);
}


class FetchBarberRepositoryImpl implements FetchBarberRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
   Stream<BarberModel?> streamBarberData(String barberUid) {
    return _firestore
    .collection('barbers')
    .doc(barberUid)
    .snapshots()
    .map((snapshot) {
      if (snapshot.exists) {
        return BarberModel.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    })
    .handleError((error) {
      log('Error fetching barber data: $error');
    });
  }
}