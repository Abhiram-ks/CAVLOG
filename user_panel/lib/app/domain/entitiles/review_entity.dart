import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewEntity { 
  final String userId;
  final double starCount;
  final String description;
  final DateTime createdAt;
  

   ReviewEntity({
    required this.userId,
    required this.starCount,
    required this.description,
    required this.createdAt,
  });

  
    Map<String, dynamic> toMap() {
    return {
    'userId': userId,
    'starCount': starCount,
    'description': description,
    'createdAt':  Timestamp.fromDate(createdAt),
    };
  }
  
}