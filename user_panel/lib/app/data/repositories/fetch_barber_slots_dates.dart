import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/date_model.dart' show DateModel;
import '../models/slot_model.dart' show SlotModel;

abstract class FetchSlotsRepository {
  Stream<List<DateModel>> streamDates(String barberUid);
  Stream<List<SlotModel>> streamSlots({required String barberUid,required DateTime selectedDate});
  
}

class FetchSlotsRepositoryImpl implements FetchSlotsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  
  @override
  Stream<List<DateModel>> streamDates(String barberUid) {
    final datesCollection = _firestore
        .collection('slots')
        .doc(barberUid)
        .collection('dates');

    return datesCollection.snapshots().map((datesSnapshot) {
      try {
        return datesSnapshot.docs.map((doc) {
          return DateModel.fromDocument(doc);
        }).toList();
      } catch (e) {
        log('Error fetching dates: $e');
        return <DateModel>[];  
      }
    });
  }

  @override
  Stream<List<SlotModel>> streamSlots({required String barberUid, required DateTime selectedDate }) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    log('formatted Date in fetching specific day is: $formattedDate');

    final datesCollection = _firestore
        .collection('slots')
        .doc(barberUid)
        .collection('dates')
        .doc(formattedDate)
        .collection('slot')
        .orderBy('dateTime');

    return datesCollection.snapshots().map((slotSnapshot) {
      try {

        final List<SlotModel> allSlots = slotSnapshot.docs.map((doc) => SlotModel.fromMap(doc.data())).toList();

        allSlots.sort((a,b) => a.dateTime.compareTo(b.dateTime));
        log('return fetching datas is $allSlots');
        return allSlots;
      } catch (e) {
        log('Error fetching slots: $e');
        return <SlotModel>[];
      }
    });
  }
}

