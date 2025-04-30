import 'package:barber_pannel/cavlog/app/domain/repositories/slot_update_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotUpdateRepositoryImpl implements UpdateSlotRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


//**********************************************
//* @Handles updating availability for a specific slot */

  @override
  Future<bool> updateSlotAvailability({required String shopId, required String docId, required String subDocId, required bool status}) async {
    try {
      final slotDocRef = _firestore
          .collection('slots')
          .doc(shopId)
          .collection('dates')
          .doc(docId)
          .collection('slot')
          .doc(subDocId);

          await slotDocRef.update({'available': status});
          return true;
    } catch (e) {
      return false;
    }
  }
 
 //**********************************************
//! Handles deletion of a specific slot based on date and time */?

  @override
  Future<bool> deleteSlotsFunction({required String shopId, required String docId, required String subDocId}) async {
    try {
        final slotDocRef = _firestore
          .collection('slots')
          .doc(shopId)
          .collection('dates')
          .doc(docId)
          .collection('slot')
          .doc(subDocId);

        await slotDocRef.delete();
        return true;
    } catch (e) {  
      return false;
    }
  }
}