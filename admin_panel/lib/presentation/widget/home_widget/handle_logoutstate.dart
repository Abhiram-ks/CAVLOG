import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/core/routes/routes.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/alertbox_helper.dart';

void handleLogoutState(BuildContext context, LogoutState state) {
  if (state is ShowLogoutDialogState) {
  BottomSheetHelper().showBottomSheet(
  context: context,
  title: "Session Expiration Warning!",
  description: "Are you sure you want to logout? This will remove your session and log you out.",
  firstButtonText: 'Yes, Log Out',
  firstButtonAction: () {
    BlocProvider.of<LogoutBloc>(context).add(ConfirmLogoutEvent());
    Navigator.pop(context); 
  },
  firstButtonColor: AppPalette.redClr,
  secondButtonText: 'No, Cancel',
  secondButtonAction: () {
    BlocProvider.of<LogoutBloc>(context).add(CancelLogoutEvent());

  },
  secondButtonColor: AppPalette.blackClr,
);
  } else if (state is LogoutCancelState) {
    Navigator.pop(context);
  } else if (state is LogoutSuccessState) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.login, (route) => false);
  } else if (state is LogoutFailureState) {
    CustomeSnackBar.show(
      context: context,
      title: 'Logout Request Failed',
      description: 'Oops! Your logout request failed. ${state.message}',
      iconColor: AppPalette.lightOrengeclr,
      icon: CupertinoIcons.clear_circled,
    );
  }
}
