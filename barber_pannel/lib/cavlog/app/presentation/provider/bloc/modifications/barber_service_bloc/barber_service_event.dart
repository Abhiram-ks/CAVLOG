part of 'barber_service_bloc.dart';

abstract class BarberServiceEvent {}

final class AddSingleBarberServiceEvent extends BarberServiceEvent {
  final String serviceName;
  final double amount;

  AddSingleBarberServiceEvent({
    required this.serviceName,
    required this.amount,
  });
}

final class ConfirmationBarberServiceEvent extends BarberServiceEvent {}
