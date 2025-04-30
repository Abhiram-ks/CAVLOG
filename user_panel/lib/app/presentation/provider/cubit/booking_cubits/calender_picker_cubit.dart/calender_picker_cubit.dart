import 'package:flutter_bloc/flutter_bloc.dart';

part 'calender_picker_state.dart';

class CalenderPickerCubit extends Cubit<CalenderPickerState> {
  CalenderPickerCubit() : super(CalenderPickerState(DateTime.now()));

  void updateSelectedDate(DateTime newDate) {
    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);
    final selectedDate = DateTime(newDate.year, newDate.month, newDate.day);

    if (!selectedDate.isBefore(currentDate)) {
      emit(CalenderPickerState(selectedDate));
    }
  }
}
