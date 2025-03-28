import 'package:admin/core/common/alertbox_helper.dart';
import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/requstbox/requstbox_bloc.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/requests/rejection_alertbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handRequsetState(BuildContext context, RequstboxState state){
  if (state is AcceptAllertbox) {
      BottomSheetHelper().showBottomSheet(
      context: context,
      title: 'Confirm Barber Request',
      description: 'Do you want to approve this request for a barber and appoint a new barber in the community?',
      firstButtonText: 'Allow',
      firstButtonAction: () {
        context.read<RequstboxBloc>().add(AcceptActionAllow());
        Navigator.pop(context);
      },
      firstButtonColor: AppPalette.blueClr,
      secondButtonText: "Don't Allow",
      secondButtonAction: () {
        Navigator.pop(context);
      },
      secondButtonColor: AppPalette.blueClr,
    );
  } else if(state is RequstboxError){
    CustomeSnackBar.show(
      context: context,
      title: 'Request Failed',
      description: 'Warning! The request could not be processed due to an error: ${state.error}. Please try again.',
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.clear);
  } else if(state is RejectAllowAlertBox){
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return RejectionAlertbox(
        textIcon: CupertinoIcons.mail_solid,
        label: 'Reason for Rejection',
        hintText: 'Please provide a valid reason for rejection',

        title: "Rejection Confirmation",
        firstButtonText: "Confirm",
        firstButtonAction: (reason) {
            context.read<RequstboxBloc>().add(RejectActionAllowReason(reason: reason));
            Navigator.pop(context);
        },
        firstButtonColor: AppPalette.redClr,
        secondButtonText: "Cancel",
        secondButtonAction: () {
          Navigator.pop(context);
        },
        secondButtonColor: AppPalette.blackClr,
      );
    },
  );
  }

}