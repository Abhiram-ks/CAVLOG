part of 'pick_image_bloc.dart';

sealed class PickImageState{}

final class PickImageInitial extends PickImageState {}
final class ImagePickerLoading extends PickImageState {}

final class ImagePickerSuccess extends PickImageState {
  final String imagePath;
  ImagePickerSuccess(this.imagePath);
}

final class ImagePickerError  extends PickImageState {
  final String errorMessage;
  ImagePickerError (this.errorMessage);
}
