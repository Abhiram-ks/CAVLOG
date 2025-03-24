import 'package:flutter/cupertino.dart';
import '../../../core/common/snackbar_helper.dart';
import '../../../core/routes/routes.dart';
import '../../../core/themes/colors.dart';
import '../../provider/bloc/loging/login_bloc.dart';

void handleLoginState(BuildContext context, LoginState state) {
  if (state is LoginSuccess) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }else if (state is LoginFiled) {
    CustomeSnackBar.show(
      context: context,
      title: 'Login failed !',
      description: 'Oops! Login failed. Error: ${state.error}. Please try again',
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.clear_circled,
    );
  }
}