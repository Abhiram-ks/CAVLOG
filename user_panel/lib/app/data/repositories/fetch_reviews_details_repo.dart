import 'package:cloud_firestore/cloud_firestore.dart';
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

      final userFetches = reviews.map((item) async {
        try {
          final userSnapshot = await _firestore.collection('users').doc(item['userId']).get();
          if (userSnapshot.exists) {
            final userData = userSnapshot.data()!;
            return ReviewModel.fromReviewAndUser(
              reviewId: item['reviewId'],
              reviewData: item['reviewData'],
              userData: userData,
            );
          }
        } catch (e) {
          return null;
        }
        return null;
      });

      final allReviews = await Future.wait(userFetches);
      return allReviews.whereType<ReviewModel>().toList();
    });
  }
}



Future<List<ReviewModel>>  buidReviewModels(List<Map<String, dynamic>> items) async {
  List<ReviewModel> reviews = [];

  for (var item  in items) {
    
  }
}