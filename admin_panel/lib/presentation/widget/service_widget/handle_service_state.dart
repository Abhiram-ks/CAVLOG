import 'package:admin/core/common/alertbox_helper.dart';
import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/widget/manage_barbers_widget/requests/rejection_alertbox.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../provider/bloc/service_management/service_mangement_bloc.dart';

void handSeviceState(BuildContext context, ServiceMangementState state){
  if (state is UploadServiceSuccessState) {
    CustomeSnackBar.show(
      context: context,
      title: 'Service Uploaded Successfully',
      description: 'The new service has been successfully added to the database. Process completed without any errors.',
      iconColor: AppPalette.greenClr,
      icon: CupertinoIcons.checkmark_alt_circle);
  }else if (state is ServiceErrorState){
    CustomeSnackBar.show(
      context: context,
      title: 'Service Database Connection Error!',
      description: 'Unfortunately, the process failed due to: ${state.error}. Please try again.',
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.cloud_upload);
  }else if (state is ShowDeleteServiceAlert){
    BottomSheetHelper().showBottomSheet(
      context: context, 
      title: 'Service Deletion Confirmation',
       description:"Confirm deletion? This action is irreversible, and the service will be permanently removed from the database.",
       firstButtonText: 'Allow', 
       firstButtonAction: (){
        context.read<ServiceMangementBloc>().add(DeleteConfirmation());
        Navigator.pop(context);
       }, 
       firstButtonColor: AppPalette.redClr, 
       secondButtonText: "Don't Allow", 
       secondButtonAction: (){
        Navigator.pop(context);
       },
        secondButtonColor: AppPalette.blackClr);
  }else if( state is ShowEditServiceTestFeld){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return RejectionAlertbox(
          title: state.currentService,
          firstButtonText:'Update', 
          firstButtonAction: (reason){
            context.read<ServiceMangementBloc>().add(UpdateServiceEvent(reason));
            Navigator.pop(context);
          }, 
          firstButtonColor: AppPalette.blueClr,
           secondButtonText: 'Cancel', 
           secondButtonAction: ()=> Navigator.pop(context), 
           label: 'Update Services', 
           secondButtonColor: AppPalette.blackClr, 
           textIcon: CupertinoIcons.arrow_up_doc_fill, 
           hintText: 'Please Enter Service',
           initialReason: state.currentService,
          );
      });
  }
}