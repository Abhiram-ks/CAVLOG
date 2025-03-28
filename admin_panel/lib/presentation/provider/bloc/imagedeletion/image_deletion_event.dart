part of 'image_deletion_bloc.dart';

abstract class ImageDeletionEvent {}

final class ImageDeletionAction extends ImageDeletionEvent{
  final String imageUrl;
  final int index;
  final int imageIndex;

  ImageDeletionAction({required this.imageUrl, required this.index, required this.imageIndex});
}

final class ImageDeletionConfirm extends ImageDeletionEvent{}
