import 'package:admin/data/models/service_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRepository {
  final FirebaseFirestore firestore;

  ServiceRepository(this.firestore);

  
  Stream<List<ServiceModels>> getServiceStream() async*{
    try {
      yield* firestore.collection('services').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => ServiceModels.fromFirestore(doc.data())).toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}