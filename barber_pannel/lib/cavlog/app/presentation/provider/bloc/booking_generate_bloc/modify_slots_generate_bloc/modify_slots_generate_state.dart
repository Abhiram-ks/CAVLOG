part of 'modify_slots_generate_bloc.dart';

@immutable
abstract class ModifySlotsGenerateState  {}

final class ModifySlotsInitial extends ModifySlotsGenerateState {}


final class SlotStatusChangeSuccess extends ModifySlotsGenerateState {}

final class SlotStatusChangeFailure extends ModifySlotsGenerateState {
  final String errorMessage;
  final String dateMessage;

  SlotStatusChangeFailure(this.dateMessage, this.errorMessage);
}

final class ShowDeleteSlotAlert extends ModifySlotsGenerateState {
  final String time;
  final String date;

  ShowDeleteSlotAlert(this.time, this.date);
}

final class DeleteSlotLoading extends ModifySlotsGenerateState {}

final class DeleteSlotSuccess extends ModifySlotsGenerateState {}

final class DeleteSlotFailure extends ModifySlotsGenerateState {
  final String errorMessage;

  DeleteSlotFailure(this.errorMessage);
}
