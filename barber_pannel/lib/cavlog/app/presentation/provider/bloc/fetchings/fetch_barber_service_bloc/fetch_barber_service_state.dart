part of 'fetch_barber_service_bloc.dart';

sealed class FetchBarberServiceState {}

final class FetchBarberServiceInitial extends FetchBarberServiceState {}

//---------------------------------------------------------------------\\
//! Fetch Barber All service.

final class FetchBarberServiceLoading extends FetchBarberServiceState {}

final class FetchBarberServiceSuccess extends FetchBarberServiceState {
  final List<BarberServiceModel> services;

  FetchBarberServiceSuccess({required this.services});
}

final class FetchBarberServiceEmpty extends FetchBarberServiceState {}

final class FetchBarberServiceError extends FetchBarberServiceState {
  final String error;

  FetchBarberServiceError({required this.error});
}


