import 'dart:developer';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/buttomnav/buttom_nav_cubit.dart';
import 'package:barber_pannel/services/barber_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);
         String? id = prefs.getString('barberUid');
        log('message: logout barberuid $id'); 
        await prefs.remove('barberUid');
          bottomNavCubit.selectItem(BottomNavItem.home);
        BarberManger().clearUser();
        log('message: user logged out and shared preference cleared.');
        emit(LogoutSuccessState());
      } catch (e) {
        log('message: error during logout: $e');
        emit(LogoutErrorState('Message: error during logout: $e'));
      }
    });
  }
}
