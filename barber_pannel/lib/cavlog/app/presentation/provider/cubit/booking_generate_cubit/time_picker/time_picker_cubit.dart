import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit() : super(TimePickerState(
    startTime: TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute ),
    endTime: TimeOfDay(hour: 19, minute: 0),
  ));

  void updateStartTime(TimeOfDay newTime) {
    emit(state.copyWith(startTime: newTime));
  }

  void updateEndtime(TimeOfDay newTime) {
    emit(state.copyWith(endTime: newTime));
  }
}
