import 'package:admin/core/common/alertbox_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/requstbox/requstbox_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handResetPasswordState(BuildContext context, RequstboxState state){
  if (state is AcceptAllertbox) {
     AlertBoxHelper().showAlertDialog(
    context:context,
    title: 'Confirm Barber Request',
    description: 'Do you want to approve this request for a barber and appoint a new barber in the community?',
    firstButtonText: 'Allow',
    firstButtonAction: () {
      context.read<RequstboxBloc>().add(AcceptActionAllow());
      Navigator.pop(context);
    },
    firstButtonColor: AppPalette.blueClr,
    secoundButtonText: "Don't Allow",
    secoundButtonAction: (){
      context.read<RequstboxBloc>().add(AcceptActionACancel());
    },
    secoundButtonColor: AppPalette.blueClr,
    );
  } else if(state is AcceptAlertDismiss){
    Navigator.pop(context);
  }

}