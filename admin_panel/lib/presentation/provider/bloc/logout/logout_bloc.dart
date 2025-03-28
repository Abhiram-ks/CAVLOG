import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutActionEvent>((event, emit) {
      emit(ShowLogoutDialogState());
    });

    on<ConfirmLogoutEvent>((event, emit) async {
      try {
         final SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setBool('isAdminLog', false);
         emit(LogoutSuccessState());
      } catch (e) {
         emit(LogoutFailureState('Log out failure due to: $e'));
      }
    
    });

    on<CancelLogoutEvent>((event, emit) {
      emit(LogoutCancelState());
    });
  }
}
