part of 'barberstatus_bloc.dart';

sealed class BarberstatusState {}

final class BarberstatusInitial extends BarberstatusState {}
final class ShowBlockAlertState extends BarberstatusState {}
final class BlockSuccessState extends BarberstatusState {}

final class ShowUnblockAlertState  extends BarberstatusState{}
final class UnBlockSuccessState extends BarberstatusState {}

final class StatusErrorState extends BarberstatusState{
  final String error;

  StatusErrorState(this.error);
}