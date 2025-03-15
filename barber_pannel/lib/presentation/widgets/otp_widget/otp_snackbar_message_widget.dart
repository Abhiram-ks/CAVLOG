
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/common/snackbar_common.dart';
import '../../../core/themes/colors.dart';
import '../../provider/bloc/RegisterSubmition/register_submition_bloc.dart';

void handleOtpState(
    BuildContext context, RegisterSubmitionState state, bool otpsed) {
  if (state is OtpLoading) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed
          ? "Sending OTP to Email..."
          : "Resending Authentication Email...",
      description: otpsed
          ? "Please wait while we send your OTP email."
          : "We're resending the verification email. Please wait...",
      iconColor: AppPalette.orengeClr,
      icon: CupertinoIcons.mail_solid,
    );
  } else if (state is OtpSuccess) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed ? "OTP Sent Successfully" : "Verification Email Resent!",
      description: otpsed
          ? "Check your inbox and enter the OTP to continue."
          : "Check your inbox and verify your email to proceed.",
      iconColor: AppPalette.greenClr,
      icon: otpsed ? Icons.mark_email_read_rounded : CupertinoIcons.mail_solid,
    );
  } else if (state is OtpFailure) {
    CustomeSnackBar.show(
      context: context,
      title: otpsed ? "OTP Sending Failed" : "Resend Failed!",
      description: otpsed
          ? "We couldn't send the OTP. Error: ${state.error}"
          : "We couldn't resend the email. Error: ${state.error}",
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.mail_solid,
    );
  }
}


