
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../../../core/common/snackbar_helper.dart';
import '../../../../../../../core/themes/colors.dart';
import '../../../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import '../../../../provider/bloc/booking_generate_bloc/modify_slots_generate_bloc/modify_slots_generate_bloc.dart';

void handleSlotUpdatesState(BuildContext context, ModifySlotsGenerateState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();

    //! Handles the state session for slot deletion
  if (state is ShowDeleteSlotAlert ) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation!',
        description: 'Are you sure you want to permanently delete the session on ${state.date} at ${state.time}?',
        firstButtonText: 'Allow',
        firstButtonAction: () {
          context.read<ModifySlotsGenerateBloc>().add(ConfirmDeleteGeneratedSlotEvent());
        },
        firstButtonColor: AppPalette.redClr,
        secondButtonText: "Don't allow",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blackClr);
  } else if (state is DeleteSlotLoading) {
    buttonCubit.bottomSheetStart();
  } else if (state is DeleteSlotSuccess) {
    buttonCubit.bottomSheetStop();
    Navigator.pop(context);
    CustomeSnackBar.show(
      context: context,
      title: 'Session Successful!',
      description: 'Slots were deleted successfully! Feel free to make other adjustments.',
      titleClr: AppPalette.greenClr,
    );
  } else if (state is DeleteSlotFailure) {
    buttonCubit.bottomSheetStop();
    Navigator.pop(context);
    CustomeSnackBar.show(
        context: context,
        title: "Session Failed!",
        description: "Oops! ${state.errorMessage}. The session could not be deleted. Please try again.",
        titleClr: AppPalette.redClr);
  }


  //! Handles the state session for slot Update
  else if(state is SlotStatusChangeFailure) {
     Navigator.pop(context);
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
        context: context,
        title: "Session Failed!",
        description: "Oops! ${state.errorMessage} The session couldn't be updated on ${state.dateMessage}. Please try again later.",
        titleClr: AppPalette.redClr);
  }
}
