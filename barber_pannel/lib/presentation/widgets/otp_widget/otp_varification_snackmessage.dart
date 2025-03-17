import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/snackbar_helper.dart';
import '../../../core/themes/colors.dart';
import '../../provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'navigation_to_admin.dart';

void handleOTPVarificationState(
    BuildContext context, RegisterSubmitionState state, ) {
   if (state is OtpVarifyed) {
     context.read<RegisterSubmitionBloc>().add(SubmitRegistration());
     navigateToAdminRequest(context);
  }
  if (state is OtpIncorrect) {
    CustomeSnackBar.show(
      context: context,
      title: 'Invalid OTP',
      description: "Oops! The OTP you entered is incorrect. Please check and try again. Error: ${state.error}",
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.number,
    );
  } else if (state is OtpExpired) {
    CustomeSnackBar.show(
      context: context,
      title: 'OTP Expired',
      description:
          "Oops! The OTP you entered has expired. Please request a new OTP.",
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.time_solid,
    );
  }
}