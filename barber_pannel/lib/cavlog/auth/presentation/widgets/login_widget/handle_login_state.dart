
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/Login_bloc/login_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/widgets/otp_widget/navigation_to_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../provider/cubit/buttonProgress/button_progress_cubit.dart';

void handleLoginState(BuildContext context, LoginState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();

  if (state is LoginLoading) {
    buttonCubit.startLoading();
  }
  else if(state is LoginBlocked){
   Navigator.pushNamed(context, AppRoutes.blocked);
   buttonCubit.stopLoading(); 
  }else if(state is LoginVarified) {
     Navigator.pushReplacementNamed(context, AppRoutes.home);
     buttonCubit.stopLoading(); 
  } else if (state is LoginNotVerified) {
    navigateToAdminRequest(context);
    buttonCubit.stopLoading(); 
  } else if (state is LoginFiled) {
    String errorMessage = 'Login failed';

    if (state.error.contains("Incorrect Email or Password")) {
      errorMessage = 'Incorrect Email or Password';
    } else if (state.error.contains("Too many requests")) {
      errorMessage = 'Too many requests';
    } else if (state.error.contains("Network Error")) {
      errorMessage = 'Connection failed';
    }

    CustomeSnackBar.show(
      context: context,
      title: errorMessage,
      description: 'Oops! Login failed. Error: ${state.error}',
      titleClr: AppPalette.redClr,
    );
    buttonCubit.stopLoading(); 
  }
}