import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/domain/entitiles/review_entity.dart';

abstract class ReviewRepository  {
  Future<bool> addReview(String shopId, ReviewEntity review);
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
}