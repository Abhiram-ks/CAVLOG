part of 'barber_service_bloc.dart';

abstract class BarberServiceState{}

final class BarberServiceInitial extends BarberServiceState {}

final class ConfirmationAlertState extends BarberServiceState {
  final String text;
  final double amount;
  ConfirmationAlertState(this.text, this.amount);
}

final class BarberServiceLoading extends BarberServiceState {}

final class BarberServiceSuccess extends BarberServiceState {}

final class BarberServiceFailure extends BarberServiceState {
  final String error;

  BarberServiceFailure(this.error);
}
