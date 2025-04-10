part of 'fetch_allbarber_bloc.dart';

abstract class FetchAllbarberState  {
}

final class FetchAllbarberInitial extends FetchAllbarberState {}
final class FetchAllbarberLoading extends FetchAllbarberState {}
final class FetchAllbarberSuccess extends FetchAllbarberState {
  final List<BarberModel> barbers;
   FetchAllbarberSuccess({required this.barbers});
}


final class FetchAllbarberEmpty extends FetchAllbarberState {}
final class  FetchAllbarberFailure extends FetchAllbarberState {
  final String errorerror;

  FetchAllbarberFailure(this.errorerror);
}