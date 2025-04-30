part of 'time_picker_cubit.dart';

class TimePickerState{
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimePickerState({
    required this.startTime,
    required this.endTime
  });

  TimePickerState copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime
  }) {
    return TimePickerState(
      startTime: startTime?? this.startTime, 
      endTime: endTime ?? this.endTime);
  }
}
