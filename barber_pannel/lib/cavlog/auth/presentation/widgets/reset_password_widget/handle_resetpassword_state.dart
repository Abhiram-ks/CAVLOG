import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/ResetPasswordBloc/reset_password_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../provider/cubit/buttonProgress/button_progress_cubit.dart';

void handResetPasswordState(BuildContext context, ResetPasswordState state){
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is ResetPasswordLoading) {
    buttonCubit.startLoading();
  }
  if (state is ResetPasswordSuccess) {
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
    context: context,
    title: "Success",
    description: "Done! Open your inbox and follow the instructions to reset your password.",
    titleClr: AppPalette.greenClr,
    );
  } else if(state is ResetPasswordFailure){
    buttonCubit.stopLoading();
    CustomeSnackBar.show(context: context, title: "Password Reset Mail Failed",
    description: "Oops! Something went wrong: ${state.error}. Please try again.", titleClr: AppPalette.redClr,);
  }

}