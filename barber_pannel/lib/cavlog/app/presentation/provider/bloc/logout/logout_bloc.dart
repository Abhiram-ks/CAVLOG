import 'dart:developer';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/buttomnav/buttom_nav_cubit.dart';
import 'package:barber_pannel/core/refresh/refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
    final ButtomNavCubit bottomNavCubit;
  LogoutBloc(this.bottomNavCubit) : super(LogoutInitial()) {
    on<LogoutActionEvent>((event, emit) {
      emit(ShowLogoutAlertState());
    });
    
    on<LogoutConfirmationEvent>((event, emit) async{
      emit(LogoutInitial());
      try {
        final bool response = await RefreshHelper().logOut();
        if (response) {
          bottomNavCubit.selectItem(BottomNavItem.home);
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
