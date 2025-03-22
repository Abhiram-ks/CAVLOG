import 'dart:developer';

import 'package:admin/data/repositories/accept_email_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AcceptBarberRemoteDataSorce {

  Stream<bool> updateBarberVerificationStatus(String uid, String barberName, String ventureName, String emaiId);
}

class AcceptReqRemoteData implements AcceptBarberRemoteDataSorce {
   final FirebaseFirestore firestore;
   
   AcceptReqRemoteData(this.firestore);
   
   @override
  Stream<bool> updateBarberVerificationStatus(String uid, String barberName, String ventureName, String emaiId) async* {
      try {
        await firestore.collection('barbers').doc(uid).update({'isVerified': true});

        final emailSent = await EmailService().sendAcceptEmail(emaiId, barberName, ventureName, uid);
   
        if (emailSent) {
          yield true;
        }else{
          yield false;
        }
      } catch (e) {
        log("Error updating verification Status: $e");
        yield false;
      }
    }
  
}