import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import '../../../../../core/common/custom_bottomsheet_widget.dart';
import '../../../../../core/common/custom_snackbar_widget.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/themes/colors.dart';
import '../../../provider/bloc/logout_bloc/logout_bloc.dart';

void handleLogOutState(BuildContext context, LogoutState state) {
    final buttonCubit = context.read<ButtonProgressCubit>();
  if(state is LogoutLoading){
    buttonCubit.bottomSheetStart();
  }
  if (state is ShowLogoutDialog) {
    BottomSheetHelper().showBottomSheet(
      context: context,
      title: "Session Expiration Warning!",
      description:
          "Are you sure you want to logout? This will remove your session and log you out.",
      firstButtonText: 'Yes, Log Out',
      firstButtonAction: () {
        context.read<LogoutBloc>().add(LogoutConfirmEvent());
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
     buttonCubit.bottomSheetStart();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  } else if (state is LogoutErrorState) {
     buttonCubit.bottomSheetStop();
     CustomeSnackBar.show(
      context: context,
      title: 'Logout Request Failed',
      description: 'Oops! Your logout request failed. ${state.errorMessage}',
      titleClr: AppPalette.buttonClr,
    );
  }
}
