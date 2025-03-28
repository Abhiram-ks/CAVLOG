import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceRepository  {
  final FirebaseFirestore firestore;

  FirebaseServiceRepository(this.firestore);

  Future<bool> uploadService(String serviceName)async{

    try {
      final serviceId = firestore.collection('services').doc().id;
        await firestore.collection('services').doc(serviceId).set({
      'id': serviceId,
      'name': serviceName
      });
       return true;
    } catch (e) {
      return false;
    }
  }
  
   Future<bool> updateService({required String serviceId, required String updatedService}) async{
    try {
      await firestore.collection('services').doc(serviceId).update({'name':updatedService});

      return true;
    } catch (e) { 
      return false;
    }
   }

   Future<bool> deleteService({required String serviceId}) async{
    try {
      await firestore.collection('services').doc(serviceId).delete();
      return true;
    } catch (e) {
      return false;
    }
   }

}