import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/googlesign_bloc/googlesign_bloc.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/colors.dart';
import '../../provider/cubit/button_progress_cubit/button_progress_cubit.dart';

void handleGoogleVarificationState(
  BuildContext context, GooglesignState state){
     final buttonCubit = context.read<ButtonProgressCubit>();
   if (state is GoogleSignLoading) {
     buttonCubit.googleSingInStart();
   }
  else if(state is GoogleSignSuccess) {
     Navigator.pushReplacementNamed(context, AppRoutes.home);
     buttonCubit.googleSingInStop();
  } else if (state is GoogleSignfailure) {
    buttonCubit.googleSingInStop();
    String errorMessage = 'Login failed';

    if (state.error.contains("Incorrect Email or Password")) {
      errorMessage = 'Incorrect Email or Password';
    } else if (state.error.contains("Too many requests")) {
      errorMessage = 'Too many requests';
    } else if (state.error.contains("Network Error")) {
      errorMessage = 'Connection failed';
    } else if (state.error.contains("Email already in use")){
      errorMessage = 'Email already in use';
    }

    CustomeSnackBar.show(
      context: context,
      title: errorMessage,
      description: 'Oops! Login failed. Error: ${state.error}',
      titleClr: AppPalette.redClr,
    );
  }
}