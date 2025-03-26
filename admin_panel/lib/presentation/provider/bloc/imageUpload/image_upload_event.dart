part of 'image_upload_bloc.dart';

abstract class ImageUploadEvent {
}

class ImageUploadRequested  extends ImageUploadEvent {
  final String imageUrl;
  final int index;

  ImageUploadRequested({required this.imageUrl, required this.index});

}