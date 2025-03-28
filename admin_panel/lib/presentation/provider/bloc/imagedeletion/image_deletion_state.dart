part of 'image_deletion_bloc.dart';

abstract class ImageDeletionState{}

final class ImageDeletionInitial extends ImageDeletionState {}
final class ImageDeletionProcess extends ImageDeletionState {}
final class ShowAlertConfirmation extends ImageDeletionState {}
final class ImageDeletionSuccess extends ImageDeletionState {}
final class ImageDeletionFailure extends ImageDeletionState {
  final String error;
  ImageDeletionFailure(this.error);
}
