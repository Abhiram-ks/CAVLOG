import 'package:admin/core/common/snackbar_helper.dart';
import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/imageUpload/image_upload_bloc.dart';
import 'package:flutter/cupertino.dart';

void handleImagUploadState(BuildContext context, ImageUploadState state) {
  if (state is ImageUploadError) {
    CustomeSnackBar.show(
      context: context,
      title: 'Image Upload Failed',
      description: "The image upload process failed due to the following error: ${state.error}. Please try again.",
      iconColor: AppPalette.redClr,
      icon: CupertinoIcons.cloud_upload,
    );
  }else if(state is ImageUploadSuccess){
    CustomeSnackBar.show(
      context: context,
      title: 'Image Upload Successful',
     description: "The banner upload process has been completed successfully. The image upload is now complete.",
      iconColor: AppPalette.greenClr,
      icon: CupertinoIcons.cloud_upload,
    );
  }
}