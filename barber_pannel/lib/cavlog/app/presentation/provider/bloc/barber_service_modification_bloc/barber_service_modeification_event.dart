part of 'barber_service_modeification_bloc.dart';

abstract class BarberServiceModeificationEvent  {}



//-----------------------------------------------------\\
//!Delete Barber service event
final class FetchBarberServicDeleteRequestEvent extends BarberServiceModeificationEvent {
  final String barberUid;
  final String serviceKey;

  FetchBarberServicDeleteRequestEvent({
    required this.barberUid,
    required this.serviceKey,
  });
}

final class FetchBarberServiceDeleteConfirmEvent extends BarberServiceModeificationEvent {}


//-----------------------------------------------------\\
//!Update Barber service event
final class FetchBarberServiceUpdateRequestEvent extends BarberServiceModeificationEvent {
  final String barberUid;
  final String serviceKey;
  final double serviceValue;
  final double oldServiceValue;

  FetchBarberServiceUpdateRequestEvent({
    required this.barberUid,
    required this.serviceKey,
    required this.serviceValue,
    required this.oldServiceValue,
  });
}

final class FetchBarberServiceUpdateConfirmEvent extends BarberServiceModeificationEvent {}
