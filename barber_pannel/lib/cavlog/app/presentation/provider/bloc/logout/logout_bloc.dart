import 'dart:developer';
import 'package:barber_pannel/core/refresh/refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutActionEvent>((event, emit) {
      emit(ShowLogoutAlertState());
    });
    
    on<LogoutConfirmationEvent>((event, emit) async{
      emit(LogoutInitial());
      try {
        final bool response = await RefreshHelper().logOut();
        if (response) {
          emit(LogoutSuccessState());
        }else{
          emit(LogoutErrorState('Logout failed'));
        }
      } catch (e) {
        log('message: error during logout: $e');
        emit(LogoutErrorState('Message: error during logout: $e'));
      }
    });
  }
}
