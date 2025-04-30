part of 'generate_slot_bloc.dart';

sealed class GenerateSlotEvent {}

class SlotGenerateRequest extends GenerateSlotEvent {
  final DateTime selectedDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DurationTime duration;

  SlotGenerateRequest({
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.duration
  });
}

class SlotGenerateConfirmation extends GenerateSlotEvent {}