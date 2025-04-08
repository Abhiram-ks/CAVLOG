import 'package:barber_pannel/core/common/custom_bottomsheet.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import '../../../provider/bloc/barber_service_bloc/barber_service_bloc.dart';

void handleBarberServiceState(BuildContext context, BarberServiceState state) {
 final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is ConfirmationAlertState) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation!',
        description:'Are you sure you want to proceed with this service? Service Name: ${state.text} & Charge: ₹${state.amount.toStringAsFixed(2)}Tap Allow to continue.',
        firstButtonText: 'Allow',
        firstButtonAction: (){
          context.read<BarberServiceBloc>().add(ConfirmationBarberServiceEvent());
          Navigator.pop(context);
        },
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: (){
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blackClr);
  }

  else if (state is BarberServiceLoading) {
    buttonCubit.startLoading();
  }

  else if (state is BarberServiceSuccess) {
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
  context: context,
  title: 'Service Uploaded',
  description: 'Your new service has been added successfully and is now available for clients.',
  titleClr: AppPalette.greenClr,
);

  } else if (state is BarberServiceFailure){
    buttonCubit.stopLoading();
    CustomeSnackBar.show(context: context, title: "Upload Failed", description:  "Oops! The service could not be uploaded due to an error: ${state.error}. Please try again.", titleClr: AppPalette.redClr);
  }
}
