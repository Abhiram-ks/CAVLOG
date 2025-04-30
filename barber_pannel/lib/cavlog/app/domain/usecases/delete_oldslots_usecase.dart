import 'dart:isolate';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DeleteOldSlotsService {
  Future<void> deleteOldSlotsWithIsolate(String barberUid) async {
    log('Starting to delete old slots for barber: $barberUid');

    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      log('Today is: ${DateFormat('dd-MM-yyyy').format(today)}');

      final dateCollectionRef = FirebaseFirestore.instance
          .collection('slots')
          .doc(barberUid)
          .collection('dates');

      final dateDocs = await dateCollectionRef.get();
      final List<String> docIds = dateDocs.docs.map((doc) => doc.id.trim()).toList();
      log('Found ${docIds.length} date documents in total');

      if (docIds.isEmpty) {
        return;
      }

      final receivePort = ReceivePort();

      await Isolate.spawn<_DeleteSlotParams>(
          _isolateEntry,
          _DeleteSlotParams(docIds, today, receivePort.sendPort));

      final List<String> oldDocIds = await receivePort.first;
       log('Found ${oldDocIds.length} dates to delete (before ${DateFormat('dd-MM-yyyy').format(today)})');

      for (String docId in oldDocIds) {
        final docRef = dateCollectionRef.doc(docId);

     
       try {
          // First delete all slot documents inside this date
          final slotSubcollection = await docRef.collection('slot').get();
          log('Deleting ${slotSubcollection.docs.length} slots for date: $docId');
          
          // Use a batch for better performance when deleting multiple documents
          WriteBatch batch = FirebaseFirestore.instance.batch();
          
          for (var slotDoc in slotSubcollection.docs) {
            batch.delete(slotDoc.reference);
          }
          
          await batch.commit();
          
          // Now delete the date document itself
          await docRef.delete();
          log('Successfully deleted date document: $docId');
        } catch (e) {
          log('Error while deleting date $docId: $e');
          // Continue with other dates even if one fails
        }
      }
      
      log('Completed deleting ${oldDocIds.length} old dates and their slots');
      return;
    } catch (e) {
      log('Error in deleteOldSlotsWithIsolate: $e');
      rethrow; // Rethrow to let the cubit handle it
    }
  }

  static void _isolateEntry(_DeleteSlotParams params) {
    List<String> oldDocIds = [];
     final dateFormat = DateFormat('dd-MM-yyyy');

    for (String docId in params.docIds) {
      try {
        DateTime docDate = dateFormat.parse(docId);
        final docDateOnly = DateTime(docDate.year, docDate.month, docDate.day);

        if (docDateOnly.isBefore(params.today)) {
          oldDocIds.add(docId);
        }
      } catch (e) {
        log('Error parsing date from document ID: $docId - $e');
        continue; 
      }
    }

    params.sendPort.send(oldDocIds);
  }
}

class _DeleteSlotParams {
  final List<String> docIds;
  final DateTime today;
  final SendPort sendPort;

  _DeleteSlotParams(this.docIds, this.today, this.sendPort);
}