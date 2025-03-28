import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/ResetPasswordBloc/reset_password_bloc.dart';
import 'package:flutter/cupertino.dart';

void handResetPasswordState(BuildContext context, ResetPasswordState state){
  if (state is ResetPasswordSuccess) {
    CustomeSnackBar.show(
    context: context,
    title: "Success",
    description: "Successfully sent reset password mail to your email",
    iconColor: AppPalette.greenClr,
    icon: CupertinoIcons.check_mark_circled_solid,
    );
  } else if(state is ResetPasswordFailure){
    CustomeSnackBar.show(context: context, title: "Password Reset Mail Failed",
    description: "Oops! Something went wrong: ${state.error}. Please try again.", iconColor: AppPalette.redClr, icon: CupertinoIcons.clear_circled);
  }

}