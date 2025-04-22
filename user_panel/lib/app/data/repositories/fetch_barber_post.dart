import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/data/models/post_model.dart';

abstract class FetchBarberPostRepository {
  Stream <List<PostModel>> fetchBarberPostData(String barberId);
}


class FetchBarberPostRepositoryImpl implements FetchBarberPostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<PostModel>> fetchBarberPostData(String barberId) {
    try {
      final collectionRef = _firestore
          .collection('posts')
          .doc(barberId)
          .collection('Post')
          .orderBy('createdAt', descending: true);

      return collectionRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return PostModel.fromDocument(barberId, doc);
        }).toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }
}
