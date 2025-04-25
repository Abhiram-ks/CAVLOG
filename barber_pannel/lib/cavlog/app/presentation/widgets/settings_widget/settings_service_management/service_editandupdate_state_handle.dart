
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../../core/common/snackbar_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import '../../../provider/bloc/modifications/barber_service_modification_bloc/barber_service_modeification_bloc.dart';

void handleServiceEditAndUpdaTeState(BuildContext context, BarberServiceModeificationState state) {
 final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is FetchBarberServiceDeleteConfirm) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation!',
        description:'Delete "${state.serviceName}" permanently? This action can’t be undone. Tap "Allow" to confirm.',
        firstButtonText: 'Allow',
        firstButtonAction: (){
          context.read<BarberServiceModeificationBloc>().add(FetchBarberServiceDeleteConfirmEvent());
        },
        progressClr: AppPalette.redClr,
        firstButtonColor: AppPalette.redClr,
        secondButtonText: "Don’t Allow",
        secondButtonAction: (){
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blackClr);
  } else if (state is FetchBarberServiceUpdateConfirm){
       BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Overriting!',
        description: 'Update "₹${state.serviceName}" to "₹${state.newServiceName}".Continue to process? Tap "Allow" to confirm. The data will be overwritten.', 
        firstButtonText: 'Allow',
        firstButtonAction: (){
         context.read<BarberServiceModeificationBloc>().add(FetchBarberServiceUpdateConfirmEvent());
        },
        progressClr: AppPalette.blueClr,
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: (){
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blueClr);
  } else if(state is FetchBarberServiceUpdateLoading){
      buttonCubit.bottomSheetStart();
  } else if(state is FetchBarberServiceUpdateSuccess){
    Navigator.pop(context);
    buttonCubit.bottomSheetStop();
        CustomeSnackBar.show(
        context: context, 
        title: 'Overwritten Successfully!',
        description:'The service has been updated, and the previous data was successfully overwritten.' ,
        titleClr: AppPalette.greenClr, 
        );
  } else if (state is FetchBarberServiceUpdateErrorState) {
     Navigator.pop(context);
    buttonCubit.bottomSheetStop();
    CustomeSnackBar.show(
    context: context,
    title: 'Overwritten Failure!',
    description: 'Oops! Unfortunately, the service could not be updated due to ${state.errorMessage}. Please try again.',
    titleClr: AppPalette.redClr,
  );
}  else if (state is  FetchBarberServiceDeleteLoading){
   buttonCubit.bottomSheetStart();
} else if (state is FetchBarberServiceDeleteSuccess){
  Navigator.pop(context);
    buttonCubit.bottomSheetStop();
        CustomeSnackBar.show(
       context: context,
       title: 'Deletion Successful!',
       description: 'The service has been deleted, and the data will be permanently removed from the database.',
        titleClr: AppPalette.orengeClr, 
        );
} else if (state is FetchBarberServiceDeleteErrorState) {
  Navigator.pop(context);
    buttonCubit.bottomSheetStop();
        CustomeSnackBar.show(
       context: context,
       title: 'Deletion Failure!',
       description: 'Oops! something gona wrong: ${state.errorMessage}. Please try again.',
        titleClr: AppPalette.redClr, 
     );
}

}
