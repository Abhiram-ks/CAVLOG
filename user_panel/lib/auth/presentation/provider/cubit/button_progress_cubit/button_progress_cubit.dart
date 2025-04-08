import 'package:bloc/bloc.dart';
part 'button_progress_state.dart';

class ButtonProgressCubit extends Cubit<ButtonProgressState> {
  ButtonProgressCubit() : super(ButtonProgressInitial());

  void startLoading(){
    emit(ButtonProgressLoading());
  }

  void stopLoading(){
    emit(ButtonProgressSuccess());
  }

  void googleSingInStart(){
    emit(GoogleSignInLoadingButton());
  }

  void googleSingInStop(){
    emit(GoogleSignInSuccessButton());
  }

  void bottomSheetStart() {
    emit(BottomSheetButtonLoading());
  }

  void bottomSheetStop() {
    emit(BottomSheetButtonSuccess());
  }
}
