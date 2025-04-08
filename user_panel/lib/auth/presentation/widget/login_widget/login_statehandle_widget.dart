import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/colors.dart';
import '../../provider/bloc/login_bloc/login_bloc.dart';
import '../../provider/cubit/button_progress_cubit/button_progress_cubit.dart';

void handleLoginState(BuildContext context, LoginState state) {
   final buttonCubit = context.read<ButtonProgressCubit>();
   if (state is LoginLoading) {
     buttonCubit.startLoading();
   }
  else if(state is LoginSuccess) {
     Navigator.pushReplacementNamed(context, AppRoutes.home);
     buttonCubit.stopLoading();
  } else if (state is LoginFiled) {
    buttonCubit.stopLoading();
    IconData errorIcon = CupertinoIcons.clear_fill;
    String errorMessage = 'Login failed';

    if (state.error.contains("Incorrect Email or Password")) {
      errorIcon = CupertinoIcons.exclamationmark_triangle_fill;
      errorMessage = 'Incorrect Email or Password';
    } else if (state.error.contains("Too many requests")) {
      errorIcon = CupertinoIcons.timer_fill;
      errorMessage = 'Too many requests';
    } else if (state.error.contains("Network Error")) {
      errorIcon = CupertinoIcons.wifi_exclamationmark;
      errorMessage = 'Connection failed';
    }

    CustomeSnackBar.show(
      context: context,
      title: errorMessage,
      description: 'Oops! Login failed. Error: ${state.error}',
      iconColor: AppPalette.redClr,
      icon: errorIcon,
    );
  }
}