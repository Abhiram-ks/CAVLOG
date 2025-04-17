import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/reset_password/reset_password_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'package:user_panel/core/common/custom_snackbar_widget.dart';

import '../../../../core/themes/colors.dart';

void handResetPasswordState(BuildContext context, ResetPasswordState state){
  final butttonCubit = context.read<ButtonProgressCubit>();
  if (state is ResetPasswordLoading) {
     butttonCubit.startLoading();
  } else if (state is ResetPasswordSuccess) {
    butttonCubit.stopLoading();
    CustomeSnackBar.show(
    context: context,
    title: "Success",
    description: "Done! Open your inbox and follow the instructions to reset your password.",
    titleClr: AppPalette.greenClr,
    );
  } else if (state is ResetPasswordFailure){
    butttonCubit.stopLoading();
    CustomeSnackBar.show(context: context, title: "Password Reset Mail Failed",
    description: "Oops! Something went wrong: ${state.errorMessage}", titleClr: AppPalette.redClr,);
  }
}