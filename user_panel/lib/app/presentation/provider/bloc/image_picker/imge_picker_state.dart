part of 'imge_picker_bloc.dart';

abstract class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}
final class ImagePickerLoading extends ImagePickerState {}
final class ImagePickerSuccess extends ImagePickerState {
  final String imagePath;
  ImagePickerSuccess(this.imagePath);
}

final class ImagePickerError extends ImagePickerState {
  final String errorMessage;
  ImagePickerError(this.errorMessage);
}


