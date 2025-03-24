part of 'service_mangement_bloc.dart';

abstract class ServiceMangementState  {}

final class ServiceMangementInitial extends ServiceMangementState {}
final class ServiceManagementLoaded  extends ServiceMangementState {}
final class UploadServiceSuccessState  extends ServiceMangementState {}
final class ShowDeleteServiceAlert extends ServiceMangementState {}
final class DeleteServiceConfirmationSuccess  extends ServiceMangementState {}
final class ShowEditServiceTestFeld extends ServiceMangementState {
  final String currentService;
  ShowEditServiceTestFeld(this.currentService);
}
final class EditServiceSuccessState extends ServiceMangementState {}

final class ServiceErrorState extends ServiceMangementState {
  final String error;
  ServiceErrorState({required this.error});
}


