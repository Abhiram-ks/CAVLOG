import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit() : super(TimePickerState(
    startTime: TimeOfDay(hour: 9, minute: 0),
    endTime: TimeOfDay(hour: 18, minute: 0),
  ));

  void updateStartTime(TimeOfDay newTime) {
    emit(state.copyWith(startTime: newTime));
  }

  void updateEndtime(TimeOfDay newTime) {
    emit(state.copyWith(endTime: newTime));
  }
}
