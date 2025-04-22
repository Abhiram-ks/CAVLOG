part of 'fetch_barber_id_bloc.dart';

abstract class FetchBarberIdEvent {}

final class FetchBarberDetailsAction extends FetchBarberIdEvent {
  final String barberId;
  FetchBarberDetailsAction(this.barberId);
}