import 'dart:developer';
import 'dart:isolate';
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
      
      yield* firestore.collection('barbers').snapshots().asyncMap((snapshot) async{
        final docs = snapshot.docs.map(
        (doc) => doc.data()).toList();
        return await _transformToBarberList(docs);
      });
    } catch (e) {
      log('Error in BarberRepository: $e');
      rethrow;
    }
  }

  Future<List<Barber>> _transformToBarberList(List<Map<String, dynamic>> docs) async {
    final receivePort  = ReceivePort();
    await Isolate.spawn(_processBarbersInIsolate, [docs, receivePort.sendPort]);

    return await  receivePort.first as List<Barber>;
  }

  static void _processBarbersInIsolate(List<dynamic> args) {
    final docs = args[0] as List<Map<String, dynamic>>;
    final sendPort = args[1] as SendPort;

    final barbers = docs.map((data) => Barber.fromFirestore(data)).toList();
    sendPort.send(barbers);

  }
}