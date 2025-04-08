import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../../core/themes/colors.dart';

void handleLogOutState(BuildContext context, LogoutState state) {
  if (state is ShowLogoutAlertState) {
    BottomSheetHelper().showBottomSheet(
      context: context,
      title: "Session Expiration Warning!",
      description:
          "Are you sure you want to logout? This will remove your session and log you out.",
      firstButtonText: 'Yes, Log Out',
      firstButtonAction: () {
        context.read<LogoutBloc>().add(LogoutConfirmationEvent());
        Navigator.pop(context);
      },
      firstButtonColor: AppPalette.redClr,
      secondButtonText: 'No, Cancel',
      secondButtonAction: () {
        Navigator.pop(context);
      },
      secondButtonColor: AppPalette.blackClr,
    );
  } else if (state is LogoutSuccessState) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  } else if (state is LogoutErrorState) {
     CustomeSnackBar.show(
      context: context,
      title: 'Logout Request Failed',
      description: 'Oops! Your logout request failed. ${state.message}',
      titleClr: AppPalette.redClr,
    );
  }
}
