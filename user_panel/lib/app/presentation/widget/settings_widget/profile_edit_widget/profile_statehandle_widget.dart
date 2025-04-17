import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/updateprofile_bloc/update_profile_bloc.dart';
import 'package:user_panel/core/common/custom_bottomsheet_widget.dart';
import 'package:user_panel/core/common/custom_snackbar_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

import '../../../../../auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';

void handleProfileUpdateState (
  BuildContext context, UpdateProfileState state) {
     final buttonCubit = context.read<ButtonProgressCubit>();
    if (state is ShowConfirmAlertBox) {
     BottomSheetHelper().showBottomSheet(
      context: context, 
      title: 'Warning! Data Overwrite', 
      description: 'This will overwrite existing data and cannot be undone. Are you sure you want to continue?', 
      firstButtonText: "Allow", 
      firstButtonAction: (){
        context.read<UpdateProfileBloc>().add(ConfirmUpdateRequest());
        Navigator.pop(context);
      }, 
      firstButtonColor: AppPalette.blueClr, 
      secondButtonText: 'Don’t Allow', 
      secondButtonAction: (){
        Navigator.pop(context);
      }, 
      secondButtonColor: AppPalette.blackClr);
    }
    if(state is UpdateProfileLoading){
      buttonCubit.startLoading();
    }

    else if(state is UpdateProfileSuccess){
      buttonCubit.stopLoading();
      CustomeSnackBar.show(
        context: context, 
        title: 'Successfully Updated!', 
        description: 'profile details have been updated and the previous data has been overwritten.', 
        titleClr: AppPalette.greenClr, );
    }else if(state is UpdateProfileFailure){
      buttonCubit.stopLoading();
          CustomeSnackBar.show(
        context: context, 
        title: 'Update Failed!', 
        description: 'We couldn’t update your profile due to: ${state.errorMessage}. Please try again.', 
        titleClr: AppPalette.redClr, );
    }
  }