part of 'fetch_barber_details_bloc.dart';

abstract class FetchBarberDetailsEvent  {}

class FetchBarberServicesRequested extends FetchBarberDetailsEvent {
  final String barberId;
  FetchBarberServicesRequested(this.barberId);
}