part of 'upload_service_data_bloc.dart';

abstract class UploadServiceDataEvent {}
final class UploadServiceDataRequest extends UploadServiceDataEvent {
  final String imagePath;
  final GenderOption genderOption;

  UploadServiceDataRequest({required this.imagePath, required this.genderOption});
}


final class UploadServiceConfirmed extends UploadServiceDataEvent {}

