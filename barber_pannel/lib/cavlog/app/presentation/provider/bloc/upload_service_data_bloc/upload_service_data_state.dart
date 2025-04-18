part of 'upload_service_data_bloc.dart';

abstract class UploadServiceDataState{}

final class UploadServiceDataInitial extends UploadServiceDataState {}
final class UploadServiceDialogBox extends UploadServiceDataState {}
final class UploadServiceLoadingState extends UploadServiceDataState {}
final class UploadServiceSuccessState extends UploadServiceDataState {}
final class UploadServiceFailureState extends UploadServiceDataState {
  final String errorMessage;
  UploadServiceFailureState (this.errorMessage);
}
