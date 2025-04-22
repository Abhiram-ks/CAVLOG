import 'package:cloud_firestore/cloud_firestore.dart';

class PostUploadingRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadPost({
    required String barberId,
    required String imageUrl,
    required String description,
  }) async {
    try {
      final postRef = _firestore
          .collection('posts')
          .doc(barberId)
          .collection('Post')
          .doc();

          await postRef.set({
            'image': imageUrl,
            'description': description,
            'likes': [],
            'comments': {},
            'createdAt': FieldValue.serverTimestamp(),
          });
        return true;
    } catch (e) {
      return false;
    }
  }
}