import 'package:barber_pannel/cavlog/app/data/repositories/post_uploading_repo.dart';

class UploadPostUsecase {
  final PostUploadingRepo remoteDataSource;
  UploadPostUsecase(this.remoteDataSource);

  Future<bool> call({
    required String barberId,
    required String imageUrl,
    required String description,
  }) async {
    return await remoteDataSource.uploadPost(
      barberId: barberId, 
      imageUrl: imageUrl, 
      description: description);
  }
}