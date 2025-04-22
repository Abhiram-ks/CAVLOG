part of 'fetch_barber_details_bloc.dart';

abstract class FetchBarberDetailsState {}

final class FetchBarberDetailsInitial extends FetchBarberDetailsState {}
final class FetchBarberServicesLoading extends FetchBarberDetailsState {}
final class FetchBarberServiceSuccess extends FetchBarberDetailsState {
  final List<BarberServiceModel> barberServices;
  FetchBarberServiceSuccess(this.barberServices);
}

class FetchBarberServicesEmpty extends FetchBarberDetailsState {}

class FetchBarberServicesFailure extends FetchBarberDetailsState {
  final String error;
  FetchBarberServicesFailure(this.error);
}



