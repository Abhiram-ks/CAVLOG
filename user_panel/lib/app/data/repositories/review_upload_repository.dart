import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/domain/entitiles/review_entity.dart';

abstract class ReviewRepository  {
  Future<bool> addReview(String shopId, ReviewEntity review);
  Future<bool> reviewExist(String shopId, String userId);
}

class ReviewUploadRepositoryImpl implements ReviewRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<bool> addReview(String shopId, ReviewEntity review) async {
    
    try {
          final docRef  = firestore
         .collection('reviews')
         .doc(shopId)
         .collection('shop_reviews')
         .doc();
      
      await docRef.set(review.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> reviewExist(String shopId, String userId) async{
    try {
      final reviewCollection = firestore.collection('reviews').doc(shopId).collection('shop_reviews');

      final quarySnapshot = await reviewCollection.where('userId', isEqualTo: userId).get();

      if (quarySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
      
    } catch (e) {
      return false;
    }
  }
}