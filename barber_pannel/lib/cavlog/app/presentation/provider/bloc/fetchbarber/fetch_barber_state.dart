part of 'fetch_barber_bloc.dart';

abstract class FetchBarberState{}

final class FetchBarberInitial extends FetchBarberState {}
final class FetchBarbeLoading extends FetchBarberState{}
final class FetchBarberLoaded extends FetchBarberState{
  final BarberModel barber;
  FetchBarberLoaded({required this.barber});
}

final class FetchBarberError extends FetchBarberState {
  final String message;
  FetchBarberError(this.message);
}
