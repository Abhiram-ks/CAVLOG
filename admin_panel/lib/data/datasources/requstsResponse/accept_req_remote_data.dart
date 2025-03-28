import 'package:admin/data/repositories/accept_email_helper.dart';
import 'package:admin/data/repositories/reject_email_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RequstBarberRemoteDataSorce {
  Stream<bool> updateBarberVerificationStatus(String uid, String barberName, String ventureName, String emaiId);
  Stream<bool> updateRejectBarberVerificationStatus(String uid, String barberName, String ventureName, String emaiId, String reason);
}

class RequstRemoteData implements RequstBarberRemoteDataSorce {
   final FirebaseFirestore firestore;
   
   RequstRemoteData(this.firestore);
   
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
        yield false;
      }
    }


  @override
  Stream<bool> updateRejectBarberVerificationStatus(String uid, String barberName, String ventureName,String emaiId, String reason)async*{
    try {
      await firestore.collection('barbers').doc(uid).delete();
      final emailSent = await RejectionEmailService().sendRejectEmail(emaiId, barberName, ventureName, uid, reason);

      if (emailSent) {
        yield true;
      } else {
        yield false;
      }
    } catch (e) {
      yield false;
    }
  }
}