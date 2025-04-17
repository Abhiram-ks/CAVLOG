import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import '../../../../core/common/custom_snackbar_widget.dart';
import '../../../../core/themes/colors.dart';

void handleOtpState(
    BuildContext context, RegisterState state, bool otpsed) {
  if (state is OtpLoading) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed
          ? "Sending OTP to Email..."
          : "Resending Authentication Email...",
      description: otpsed
          ? "Please wait while we send your OTP email."
          : "We're resending the verification email. Please wait...",
      titleClr: AppPalette.orengeClr,
    );
  } else if (state is OtpSuccess) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed ? "OTP Sent Successfully" : "Verification Email Resent!",
      description: otpsed
          ? "Check your inbox and enter the OTP to continue."
          : "Check your inbox and verify your email to proceed.",
      titleClr: AppPalette.greenClr,
    );
  } else if (state is OtpFailure) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed ? "OTP Sending Failed" : "Resend Failed!",
      description: otpsed
          ? "We couldn't send the OTP. Error: ${state.error}"
          : "We couldn't resend the email. Error: ${state.error}",
      titleClr: AppPalette.redClr,
    );
  }
}


