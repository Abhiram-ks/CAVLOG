import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkbox_state.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  CheckboxCubit() : super(CheckboxUnchecked());

  void toggleCheckbox(){
    if (state is CheckboxChecked) {
      emit(CheckboxUnchecked());
    } else {
      emit(CheckboxChecked());
    }
  }
}
