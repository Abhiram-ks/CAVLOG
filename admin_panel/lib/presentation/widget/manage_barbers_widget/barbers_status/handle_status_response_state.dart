
import 'package:admin/core/common/alertbox_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/barber_status/barberstatus_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/snackbar_helper.dart';

void handStatusResponseState(BuildContext context, BarberstatusState state){
  if (state is ShowUnblockAlertState) {
    BottomSheetHelper().showBottomSheet(
      context: context,
      title: 'Confirm Barber Unblock',
      description:  'Are you sure you want to unblock this barber? This will allow the barber to continue participating in the community.',
      firstButtonText: 'Allow',
      firstButtonAction: (){
      context.read<BarberstatusBloc>().add(ConfirmUnblock());
       Navigator.pop(context);
      },
      firstButtonColor: AppPalette.blueClr,
      secondButtonText: "Don't Allow",
      secondButtonAction: (){Navigator.pop(context);}, 
      secondButtonColor: AppPalette.blueClr);
  }else if(state is ShowBlockAlertState){
        BottomSheetHelper().showBottomSheet(
      context: context,
      title: 'Confirm Barber Block',
      description: 'Are you sure you want to block this barber? Blocking will prevent the barber from continuing participation in the community.',
      firstButtonText: 'Allow',
      firstButtonAction: (){
      context.read<BarberstatusBloc>().add(ConfirmBlock());
       Navigator.pop(context);
      },
      firstButtonColor: AppPalette.blueClr,
      secondButtonText: "Don't Allow",
      secondButtonAction: (){Navigator.pop(context);}, 
      secondButtonColor: AppPalette.blueClr);
  }else if(state is StatusErrorState){
    CustomeSnackBar.show(
    context: context,
    title: 'Error Occurred During the Process',
    description: "An error occurred while updating the barber's status. Details: ${state.error}",
    iconColor: AppPalette.redClr,
    icon: CupertinoIcons.clear,
    );
  }
}