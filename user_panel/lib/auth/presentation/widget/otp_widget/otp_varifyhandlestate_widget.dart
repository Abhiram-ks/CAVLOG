import 'package:flutter/cupertino.dart';import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/core/common/custom_snackbar_widget.dart';
import 'package:user_panel/core/routes/routes.dart';

import '../../../../core/themes/colors.dart';

void handleOTPVarificationState(
  BuildContext context, RegisterState state){
  if (state is OtpVarifyed) {
    context.read<RegisterBloc>().add(RegisterSubmit());
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }
  if (state is OtpIncorrect) {
    CustomeSnackBar.show(
      context: context,
      title: 'Invalid OTP',
      description: "Oops! The OTP you entered is incorrect. Please check and try again. Error: ${state.error}",
      titleClr: AppPalette.redClr,
    );
  } else if(state is OtpExpired){
        CustomeSnackBar.show(
      context: context,
      title: 'OTP Expired',
      description: "Oops! The OTP you entered has expired. Please request a new OTP.",
      titleClr: AppPalette.redClr,
    );
  }
}
