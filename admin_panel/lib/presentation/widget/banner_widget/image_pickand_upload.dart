import 'dart:developer';
import 'package:admin/core/utils/images/app_images.dart';
import 'package:admin/presentation/provider/bloc/imageUpload/image_upload_bloc.dart';
import 'package:admin/presentation/provider/bloc/pick_image/pick_image_bloc.dart';
import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:admin/presentation/widget/banner_widget/banner_builder_widget.dart';
import 'package:admin/presentation/widget/banner_widget/handle_imagupload_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/action_button.dart';
import '../../../core/common/snackbar_helper.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';
import '../../provider/cubit/radio_button/radio_cubit.dart';

class ImagePickAndUploadWidget extends StatelessWidget {
  const ImagePickAndUploadWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstantWidgets.hight20(context),
        ImagePickerWIdget(screenWidth: screenWidth, screenHeight: screenHeight),
        ConstantWidgets.hight20(context),
        BlocBuilder<RadioCubit, RadioState>(builder: (context, state) {
          String selectedOption = "Both";
          if (state is RadioSelected) {
            selectedOption = state.selectedOption;
          }
          return SizedBox(
            height: screenHeight * 0.3,
            width: double.infinity,
            child: Column(
              children: [
                RadioListTile<String>(
                    value: 'Client',
                    groupValue: selectedOption,
                    title: Text(
                      'Client',
                      style: TextStyle(color: AppPalette.buttonClr),
                    ),
                    onChanged: (value) {
                      context.read<RadioCubit>().selectOption(value!);
                    }),
                RadioListTile<String>(
                    value: 'Barber',
                    groupValue: selectedOption,
                    title: Text('Barber',
                        style: TextStyle(color: AppPalette.buttonClr)),
                    onChanged: (value) {
                      context.read<RadioCubit>().selectOption(value!);
                    }),
                RadioListTile<String>(
                    value: 'Both',
                    groupValue: selectedOption,
                    title: Text('Both',
                        style: TextStyle(color: AppPalette.buttonClr)),
                    onChanged: (value) {
                      context.read<RadioCubit>().selectOption(value!);
                    }),
              ],
            ),
          );
        }),
        BlocListener<ImageUploadBloc, ImageUploadState>(
          listener: (context, state) {
            handleImagUploadState(context, state);
          },
          child: ActionButton(
              screenWidth: screenWidth,
              onTap: () async {
                final pickImageState =context.read<PickImageBloc>().state;
                final buttonCubit = context.read<ButtonProgressCubit>();
    
                if (pickImageState is ImagePickerSuccess) {
                  buttonCubit.startLoading();
                  final selectedOption = context.read<RadioCubit>().state;
                
                  if (selectedOption is RadioSelected) {
                   int  index = _getIndexFromOption(selectedOption.selectedOption);
                    log('Message: log index is: $index');
                  context.read<ImageUploadBloc>().add(
                    ImageUploadRequested(imageUrl: pickImageState.imagePath, index: index)
                  );
                  }
                    
                  final uploadState = context.read<ImageUploadBloc>().state;
                  await Future.delayed(const Duration(seconds: 3));
                  if (uploadState is ImageUploadError || uploadState is ImageUploadSuccess) {
                    buttonCubit.stopLoading();
                  }else{
                    buttonCubit.stopLoading();
                  }
                  
                } else if (pickImageState is PickImageInitial ||
                    pickImageState is ImagePickerError) {
                  CustomeSnackBar.show(
                      context: context,
                      title: 'Image Not Found',
                      description:
                          'Unfortunately, the process encountered an error because no image was found. Please select an image to proceed and try again.',
                      iconColor: AppPalette.redClr,
                      icon: CupertinoIcons.clear);
                } else if (pickImageState is ImagePickerLoading) {
                  CustomeSnackBar.show(
                    context: context,
                    title: 'Image Loading',
                    description:
                        "Oops! The image is loading. Please wait while the process completes.",
                    iconColor: AppPalette.lightOrengeclr,
                    icon: CupertinoIcons.clock,
                  );
                }
              },
              label: 'Upload',
              screenHight: screenHeight),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstantWidgets.hight20(context),
            Text('Banners for Barber'),
            SizedBox(
              height: screenHeight * 0.25, 
              width: screenWidth * 0.9, 
              child: CarouselView(itemExtent: screenWidth * 0.9,
              itemSnapping: true,
              enableSplash: true,
             backgroundColor: AppPalette.trasprentClr,
               children: [Image.network(
"https://res.cloudinary.com/dtkhx83zd/image/upload/v1742968990/cavlog/banner/gj3izkuxhbjshr0f89e7.jpg",filterQuality: FilterQuality.high, fit: BoxFit.contain,), Image.asset(AppImages.dashbordImage),Image.asset(AppImages.loginImageAbove),]))
          ],
        )
      ],
    );
  }
}




int _getIndexFromOption(String selectedOption){
  switch (selectedOption) {
    case 'Client':
      return 1;
    case 'Barber':
      return 2;
    case 'Both':
      return 3;
    default:
      return 0;
  }
}