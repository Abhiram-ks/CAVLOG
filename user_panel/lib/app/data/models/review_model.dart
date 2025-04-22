import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String reviewId;
  final String userId;
  final String userName;
  final String imageUrl;
  final double starCount;
  final String description;
  final DateTime createdAt;


  ReviewModel ({
    required this.reviewId,
    required this.userId,
    required this.userName,
    required this.imageUrl,
    required this.starCount,
    required this.description,
    required this.createdAt
  });
  

  factory ReviewModel.fromReviewAndUser({
    required String reviewId,
    required Map<String, dynamic> reviewData,
    required Map<String, dynamic> userData,
  }) {
    return ReviewModel(
      reviewId: reviewId,
      userId: reviewData['userId'] ?? '', 
      starCount: reviewData['starCount'] ?? 1.0, 
      description: reviewData['description'] ?? '' , 
      createdAt: (reviewData['createdAt'] as Timestamp).toDate(),
      userName: userData['userName'] ?? '', 
      imageUrl: userData['image'] ?? '', 
      );
  }
}