part of 'generate_slot_bloc.dart';

abstract class GenerateSlotState{}

final class GenerateSlotInitial extends GenerateSlotState {}

final class GenerateSlotAlertState extends GenerateSlotState {
  final DateTime selectedDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DurationTime duration;

  GenerateSlotAlertState({
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.duration
  });
}

final class GenerateSlotLoading extends GenerateSlotState {}
final class GenerateSlotGenerated extends GenerateSlotState {}
final class GenerateSLotFailure extends GenerateSlotState {
  final String errorMessage;

  GenerateSLotFailure(this.errorMessage);
}
