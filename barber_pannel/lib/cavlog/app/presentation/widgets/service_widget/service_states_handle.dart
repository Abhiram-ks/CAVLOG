import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/upload_service_data_bloc/upload_service_data_bloc.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';

void handleServiceWidgetState(BuildContext context, UploadServiceDataState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is UploadServiceDialogBox) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation Alert!',
        description:
           'Are you sure you want to upload this session? This will overwrite any previously saved session.',
        firstButtonText: 'Allow',
        firstButtonAction: () {
           context  .read<UploadServiceDataBloc>().add(UploadServiceConfirmed());
        },
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blueClr);
  } else if (state is UploadServiceLoadingState) {
    buttonCubit.startLoading();
    buttonCubit.bottomSheetStart();
  } else if (state is UploadServiceFailureState) {
    buttonCubit.stopLoading();
    buttonCubit.bottomSheetStop();
    Navigator.pop(context);
    CustomeSnackBar.show(
      context: context, 
     title: 'Upload Failed',
      description: 'We couldn’t upload the session: ${state.errorMessage}. Please try again later.',
      titleClr: AppPalette.redClr);
    } else if (state is UploadServiceSuccessState) {
      buttonCubit.stopLoading();
      buttonCubit.bottomSheetStop();
      Navigator.pop(context);
      CustomeSnackBar.show(
      context: context, 
      title: 'Upload Successful',
      description: 'The session was uploaded successfully. Please verify the updated information.',
      titleClr: AppPalette.greenClr);
    }
}
