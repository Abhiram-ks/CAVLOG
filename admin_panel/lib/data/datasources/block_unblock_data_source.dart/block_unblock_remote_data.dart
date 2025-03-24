import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class StatusBarberRemoteDataSource {
  Stream<bool> updateBarberStatusBlockORUnblock(String uid, bool val);
}

class StatusBarberRemoteData implements StatusBarberRemoteDataSource{
  final FirebaseFirestore firestore;

  StatusBarberRemoteData(this.firestore);

  @override
  Stream<bool> updateBarberStatusBlockORUnblock(String uid, bool val) async*{
    try {
      await firestore.collection('barbers').doc(uid).update({'isBlok': val});
      yield true;

    } catch (e) {
      log('Error Updation block or unblock:$e');
      yield false;
    }
  }
}