import 'dart:developer';

import 'package:admin/data/models/banner_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerRepositoty {
  final FirebaseFirestore firestore;
  BannerRepositoty(this.firestore);

  Stream<BannerModels> getUserBannerStream() {
    try {
      return firestore.collection('banner_images').doc('user_doc').snapshots().map((snapshot) {
        final data = snapshot.data() ?? {};
        return BannerModels.fromMap(data);
      });
    } catch (e) {
      log('Error while fetching user banners: $e');
      rethrow;
    }
  }
     Stream<BannerModels> getBarberBannerStream() {
    try {
      return firestore.collection('banner_images').doc('barber_doc').snapshots().map((snapshot) {
        final data = snapshot.data() ?? {};
        return BannerModels.fromMap(data);
      });
    } catch (e) {
      log('Error while fetching barber banners: $e');
      rethrow;
    }
  }
}