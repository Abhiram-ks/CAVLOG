part of 'upload_post_bloc.dart';

abstract class UploadPostState {}

final class UploadPostInitial extends UploadPostState {}

final class UploadPostShowAlert extends UploadPostState {}
final class UploadPostLoading extends UploadPostState {}
final class UploadPostSuccess extends UploadPostState {}
final class UploadPostFailure extends UploadPostState {
  final String errorMessage;
  UploadPostFailure({required this.errorMessage});
}
