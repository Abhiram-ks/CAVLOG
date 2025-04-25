part of 'barber_service_modeification_bloc.dart';

abstract class BarberServiceModeificationState {
}

final class BarberServiceModeificationInitial extends BarberServiceModeificationState {}


//---------------------------------------------------------------------\\
//! Delete Barber Service State.

final class FetchBarberServiceDeleteConfirm extends BarberServiceModeificationState{
  final String serviceName;
  FetchBarberServiceDeleteConfirm(this.serviceName);
}
final class FetchBarberServiceDeleteLoading extends BarberServiceModeificationState{}
final class FetchBarberServiceDeleteSuccess extends BarberServiceModeificationState{}
final class FetchBarberServiceDeleteErrorState extends BarberServiceModeificationState{
  final String errorMessage;
  FetchBarberServiceDeleteErrorState(this.errorMessage);
}


//---------------------------------------------------------------------\\
//! Update Barber Service State.
final class FetchBarberServiceUpdateConfirm extends BarberServiceModeificationState{
  final double serviceName;
  final double newServiceName;
  FetchBarberServiceUpdateConfirm(this.serviceName, this.newServiceName);
}
final class FetchBarberServiceUpdateLoading extends BarberServiceModeificationState{}
final class FetchBarberServiceUpdateSuccess extends BarberServiceModeificationState{}
final class FetchBarberServiceUpdateErrorState extends BarberServiceModeificationState{
  final String errorMessage;
  FetchBarberServiceUpdateErrorState(this.errorMessage);
}