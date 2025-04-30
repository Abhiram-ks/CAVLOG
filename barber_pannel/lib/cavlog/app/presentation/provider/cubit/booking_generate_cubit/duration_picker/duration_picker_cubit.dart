import 'package:bloc/bloc.dart';

enum DurationTime {basic, standard, elite}

class DurationPickerCubit extends Cubit<DurationTime> {
  DurationPickerCubit() : super(DurationTime.standard);

  void updateDuration(DurationTime plan) {
    emit(plan);
  }
} 
