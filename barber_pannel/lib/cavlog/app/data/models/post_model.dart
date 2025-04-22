import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String barberId;
  final String imageUrl;
  final String description;
  final List<String> likes;
  final Map<String, String> comments;
  final DateTime createdAt;
  final String postId;


  PostModel({
    required this.barberId,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.createdAt,
    required this.postId,
    required this.comments,
  });

  factory PostModel.fromDocument(String barberId, DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      barberId: barberId, 
      postId: doc.id, 
      imageUrl: data['image'] ?? '', 
      description: data['description'] ?? '', 
      likes: List<String>.from(data['likes'] ?? []), 
      comments: Map<String, String>.from(data['comments'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(), 
    );
  }
}