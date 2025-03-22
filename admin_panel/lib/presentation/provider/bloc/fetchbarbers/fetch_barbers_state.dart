part of 'fetch_barbers_bloc.dart';

abstract class FetchBarbersState {
}

final class FetchBarbersInitial extends FetchBarbersState {}
class BarberEmptyState extends FetchBarbersState {}
class BarberLoadedState  extends FetchBarbersState{
  final List<Barber> barbers;

  BarberLoadedState (this.barbers);
}

class BarberNoNetworkState extends FetchBarbersState{}
class BarberErrorState extends FetchBarbersState {
  final String message;
  BarberErrorState(this.message);
}
