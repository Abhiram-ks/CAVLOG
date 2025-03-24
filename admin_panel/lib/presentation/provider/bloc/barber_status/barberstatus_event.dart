part of 'barberstatus_bloc.dart';

abstract class BarberstatusEvent{}

final class ShowBlockAlert  extends BarberstatusEvent {
  String uid;
  ShowBlockAlert ({required this.uid});
}

final class ConfirmBlock extends BarberstatusEvent {}

final class ShowUnblockAlert  extends BarberstatusEvent {
  String uid;

  ShowUnblockAlert ({required this.uid});
}

final class ConfirmUnblock extends BarberstatusEvent{}