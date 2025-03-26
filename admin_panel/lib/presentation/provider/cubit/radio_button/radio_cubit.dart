import 'package:bloc/bloc.dart';

part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitial());

  void selectOption(String option){
    emit(RadioSelected(selectedOption: option));
  }
}
