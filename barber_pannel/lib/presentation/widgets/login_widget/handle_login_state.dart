import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/presentation/provider/bloc/Login_bloc/login_bloc.dart';
import 'package:barber_pannel/presentation/widgets/otp_widget/navigation_to_admin.dart';
import 'package:flutter/cupertino.dart';

void handleLoginState(BuildContext context, LoginState state) {
  if (state is LoginVarified) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  } else if (state is LoginNotVerified) {
    navigateToAdminRequest(context);
  } else if (state is LoginFiled) {
    IconData errorIcon = CupertinoIcons.clear_fill;
    String errorMessage = 'Login failed';

    if (state.error.contains("Incorrect Email or Password")) {
      errorIcon = CupertinoIcons.exclamationmark_triangle_fill;
      errorMessage = 'Incorrect Email or Password';
    } else if (state.error.contains("Too many requests")) {
      errorIcon = CupertinoIcons.timer_fill;
      errorMessage = 'Too many requests';
    } else if (state.error.contains("Network Error")) {
      errorIcon = CupertinoIcons.wifi_exclamationmark;
      errorMessage = 'Connection failed';
    }

    CustomeSnackBar.show(
      context: context,
      title: errorMessage,
      description: 'Oops! Login failed. Error: ${state.error}',
      iconColor: AppPalette.redClr,
      icon: errorIcon,
    );
  }
}