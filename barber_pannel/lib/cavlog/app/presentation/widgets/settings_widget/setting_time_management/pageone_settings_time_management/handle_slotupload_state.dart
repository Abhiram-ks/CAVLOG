import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/common/custom_bottomsheet.dart';
import '../../../../../../../core/common/snackbar_helper.dart';
import '../../../../../../../core/themes/colors.dart';
import '../../../../../../auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import '../../../../provider/bloc/booking_generate_bloc/generate_slot_bloc/generate_slot_bloc.dart';

void handleSlotUploadState(BuildContext context, GenerateSlotState state) {
  final buttonCubit = context.read<ButtonProgressCubit>();
  if (state is GenerateSlotAlertState ) {
    BottomSheetHelper().showBottomSheet(
        context: context,
        title: 'Session Confirmation!',
        description: 'You have selected ${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}.Session Time: ${state.startTime.format(context)} to ${state.endTime.format(context)}Duration: ${state.duration}.Do you want to confirm this session?',
        firstButtonText: 'Allow',
        firstButtonAction: () {
          context.read<GenerateSlotBloc>().add(SlotGenerateConfirmation());
           Navigator.pop(context);
        },
        firstButtonColor: AppPalette.blueClr,
        secondButtonText: "Maybe Later",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blueClr);
  } else if (state is GenerateSlotLoading) {
    buttonCubit.startLoading();
  } else if (state is GenerateSlotGenerated && context.findAncestorStateOfType<State>()?.mounted == true) {
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
      context: context,
      title: 'Session Successful!',
      description: 'Slots have been successfully generated and are now available for clients to book.',
      titleClr: AppPalette.greenClr,
    );
  } else if (state is GenerateSLotFailure && context.findAncestorStateOfType<State>()?.mounted == true) {
    Navigator.pop(context);
    buttonCubit.stopLoading();
    CustomeSnackBar.show(
        context: context,
        title: "Session Failed!",
        description: "Oops! ${state.errorMessage}. The session could not be generated. Please try again.",
        titleClr: AppPalette.redClr);
  }
}
