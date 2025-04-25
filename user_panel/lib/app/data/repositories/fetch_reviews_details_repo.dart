import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; 
import 'package:user_panel/app/data/models/review_model.dart';

abstract class FetchReviewsDetailsRepository {
  Stream<List<ReviewModel>> streamReviewsWithUser (String shopId);
}

class FetchReviewsDetailsRepositoryImpl implements FetchReviewsDetailsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ReviewModel>> streamReviewsWithUser(String shopId) {
    final reviewRef = _firestore
        .collection('reviews')
        .doc(shopId)
        .collection('shop_reviews')
        .orderBy('createdAt', descending: true);

    return reviewRef.snapshots().asyncMap((reviewSnapshot) async {
      final reviews = reviewSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'reviewId': doc.id,
          'reviewData': data,
          'userId': data['userId'] ?? '',
        };
      }).toList();

      final List<Map<String, dynamic>> finalDataList = [];

      await Future.wait(reviews.map((item) async {
        try {
          final userSnapshot = await _firestore.collection('users').doc(item['userId']).get();
          if(userSnapshot.exists) {
            item['userData'] = userSnapshot.data();
            finalDataList.add(item);
          }
        } catch (_) {}
      }));

      final result = await compute(buidReviewModels, finalDataList);
      log('The fetching review result is: $result');
      return result;
    });
  }
}



Future<List<ReviewModel>>  buidReviewModels(List<Map<String, dynamic>> items) async {
  List<ReviewModel> reviews = [];

  for (var item  in items) {
    try {
      final rviewModel = ReviewModel.fromReviewAndUser(
          reviewId: item['reviewId'],
          reviewData: item['reviewData'],
          userData: item['userData']
      );
      reviews.add(rviewModel);
    } catch (e) {
      log('Fetchin separte isulation Error: $e');
    }
  }
  return reviews;
}