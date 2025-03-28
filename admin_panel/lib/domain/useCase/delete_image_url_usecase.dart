import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreImageServiceDeletion{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool>  deleteImageUrl({required String imageUrl,required int index,required int imageIndex}) async{
    try {
      final String docId = _getDocIdsForIndex(index);
     
      if(docId.isEmpty){
       return false;
      }
     
      final DocumentReference<Map<String, dynamic>> docRef = firestore.collection('banner_images').doc(docId);
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
       
       if (!docSnapshot.exists) {
         return false;
       }
      
      final List<dynamic>? imageUrls = docSnapshot.data()?['image_urls'];

      if (imageIndex < 0 || imageIndex >= imageUrls!.length) {
        return false;
      }

      return await _imageUrlDeletion(imageUrls: imageUrls, imageIndex: imageIndex, docref: docRef);
    } catch (e) {
      return false;
    }
  }
}

String _getDocIdsForIndex(int index){
  if(index == 1) {
    return 'user_doc';
  }else if(index == 2){
    return 'barber_doc';
  }else{
    return '';
  }
}


Future<bool> _imageUrlDeletion({required  imageUrls, required int imageIndex, required DocumentReference<Map<String, dynamic>> docref}) async{
  try {
    final String imageUrlToDelete = imageUrls[imageIndex];
    await docref.update({'image_urls': FieldValue.arrayRemove([imageUrlToDelete])});
    return true;
  } catch (e) {
    return false;
  }
}