import 'dart:developer';

import 'package:admin/data/models/barber_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BarbersRepository {
  final FirebaseFirestore firestore;

  BarbersRepository(this.firestore);

  Future<bool> _checkNetworkConnection() async{
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Stream<List<Barber>> getBarbersStream() async*{
    try {
      final connectionAvailable = await _checkNetworkConnection();
      if (!connectionAvailable) {
        throw Exception('No Internet Connection');
      }

      yield* firestore.collection('barbers').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => Barber.fromFirestore(doc.data())).toList();
      });
    } catch (e) {
      log('Error in BarberRepository: $e');
      rethrow;
    }
  }
}