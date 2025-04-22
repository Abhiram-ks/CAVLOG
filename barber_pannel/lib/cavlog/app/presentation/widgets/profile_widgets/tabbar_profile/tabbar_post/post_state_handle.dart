import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/upload_post_bloc/upload_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../../../core/common/snackbar_helper.dart';
import '../../../../../../../core/themes/colors.dart';
import '../../../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';

void handlePostStateHelper(BuildContext context, UploadPostState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is UploadPostShowAlert) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation Alert!',
        description: 'Ready to share your post with the community? Make sure everything looks good before you continue.',
        firstButtonText: 'Allow',
        firstButtonAction: () {
          context  .read<UploadPostBloc>().add(UploadPostConfirmed());
          Navigator.pop(context);
        },
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blueClr);
  } else if (state is UploadPostLoading) {
    buttonCubit.startLoading();
  } else if (state is UploadPostFailure) {
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
      context: context, 
     title: 'Upload Failed',
      description: 'We couldn’t upload the session: ${state.errorMessage}. Please try again later.',
      titleClr: AppPalette.redClr);
    } else if (state is UploadPostSuccess) {
      buttonCubit.stopLoading();
      CustomeSnackBar.show(
      context: context, 
      title: 'Upload Successful',
      description: 'The session was uploaded successfully. Please verify the updated information.',
      titleClr: AppPalette.greenClr);
    }
}
