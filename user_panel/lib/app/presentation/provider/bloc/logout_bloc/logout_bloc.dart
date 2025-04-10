import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:user_panel/app/presentation/provider/cubit/buttom_nav_cubit/buttom_nav_cubit.dart';
import 'package:user_panel/service/refresh.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final ButtomNavCubit bottomNavCubit;
  LogoutBloc(this.bottomNavCubit) : super(LogoutInitial()) {
    on<LogoutRequestEvent>((event, emit) {
      emit(ShowLogoutDialog());
    });

    on<LogoutConfirmEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        final bool response = await RefreshHelper().logOut();
        log('logout response: $response');
        if (response) {
          bottomNavCubit.selectItem(BottomNavItem.home);
          emit(LogoutSuccessState());
        }else {
          emit(LogoutErrorState(errorMessage: 'Failed to log out. Please try again!'));
        }
      } catch (e) {
        emit(LogoutErrorState(errorMessage: 'Error occurred while loggin out: $e'));
      }
    });
  }
}
