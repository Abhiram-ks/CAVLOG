import 'dart:io';

import 'package:barber_pannel/cavlog/app/data/repositories/image_picker_repo.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/image_picker/image_picker_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/upload_service_data_bloc/upload_service_data_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/current_service_cubit/current_service_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/service_widget/service_states_handle.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../domain/usecases/image_picker_usecase.dart';
import '../../../provider/cubit/gender_cubit/gender_option_cubit.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ServicePageCubit()),
        BlocProvider(create: (context) => GenderOptionCubit()),
        BlocProvider(
            create: (context) => ImagePickerBloc(
                PickImageUseCase(ImagePickerRepositoryImpl(ImagePicker())))),
        BlocProvider(create: (context) => UploadServiceDataBloc()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;
          return ColoredBox(
            color: AppPalette.scafoldClr ?? AppPalette.whiteClr,
            child: SafeArea(
              child: Scaffold(
                  body: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                    switch (state) {
                      case CurrentServicePage.pageOne:
                        return const Center(child: Text('Page one'));

                      case CurrentServicePage.pageTwo:
                        return ViewServiceDetailsPage(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                    }
                  }),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                        final isPageOne = state == CurrentServicePage.pageOne;
                        return ActionButton(
                            screenWidth: screenWidth,
                            onTap: () {
                              if (isPageOne) {
                                context.read<ServicePageCubit>().goToPageTwo();
                              } else {
                                context.read<ServicePageCubit>().goToPageOne();
                              }
                            },
                            label: isPageOne
                                ? 'View Service Details'
                                : 'Back to Slots',
                            screenHight: screenHeight);
                      },
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}

class ViewServiceDetailsPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const ViewServiceDetailsPage(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: UploadingServiceDatas(
            screenWidth: screenWidth, screenHeight: screenHeight),
      ),
    );
  }
}

class UploadingServiceDatas extends StatelessWidget {
  const UploadingServiceDatas({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstantWidgets.hight30(context),
        InkWell(
          onTap: () {
            context.read<ImagePickerBloc>().add(PickImageAction());
          },
          child: DottedBorder(
            color: AppPalette.greyClr,
            strokeWidth: 1,
            dashPattern: [4, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.23,
              child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, state) {
                  if (state is ImagePickerInitial) {
                    return SizedBox(
                        width: screenWidth * 0.89,
                        height: screenHeight * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cloud_upload,
                              size: 35,
                              color: AppPalette.buttonClr,
                            ),
                            Text('Upload an Image')
                          ],
                        ));
                  } else if (state is ImagePickerLoading) {
                    return const CupertinoActivityIndicator(
                      radius: 16.0,
                    );
                  } else if (state is ImagePickerSuccess) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(state.imagePath),
                        width: screenWidth * 0.89,
                        height: screenHeight * 0.22,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else if (state is ImagePickerError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          size: 35,
                          color: AppPalette.redClr,
                        ),
                        Text(state.errorMessage)
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cloud_upload,
                        size: 35,
                        color: AppPalette.buttonClr,
                      ),
                      Text('Upload an Image')
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        ConstantWidgets.hight20(context),
        const Text(
          "Select Gender",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        BlocBuilder<GenderOptionCubit, GenderOption>(
          builder: (context, selectedGender) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<GenderOption>(
                      value: GenderOption.male,
                      groupValue: selectedGender,
                      activeColor: AppPalette.blueClr,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<GenderOptionCubit>()
                              .selectGenderOption(value);
                        }
                      },
                    ),
                    const Text("Male"),
                  ],
                ),
                Row(
                  children: [
                    Radio<GenderOption>(
                      value: GenderOption.female,
                      groupValue: selectedGender,
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<GenderOptionCubit>()
                              .selectGenderOption(value);
                        }
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
                Row(
                  children: [
                    Radio<GenderOption>(
                      value: GenderOption.unisex,
                      groupValue: selectedGender,
                      activeColor: AppPalette.orengeClr,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<GenderOptionCubit>()
                              .selectGenderOption(value);
                        }
                      },
                    ),
                    const Text("Unisex"),
                  ],
                ),
              ],
            );
          },
        ),
        ConstantWidgets.hight20(context),
        BlocListener<UploadServiceDataBloc, UploadServiceDataState>(
          listener: (context, state) {
            handleServiceWidgetState(context, state);
          },
          child: ActionButton(
              screenWidth: screenWidth,
              onTap: () {
                final imageState = context.read<ImagePickerBloc>().state;
                final genderState = context.read<GenderOptionCubit>().state;

                if (imageState is ImagePickerSuccess) {
                  context.read<UploadServiceDataBloc>().add(
                      UploadServiceDataRequest(
                          imagePath: imageState.imagePath,
                          genderOption: genderState));
                } else {
                  CustomeSnackBar.show(
                      context: context,
                      title: 'Image Not Found!',
                      description:
                          'Unable to proceed. Image not found. Please make sure an image is selected.',
                      titleClr: AppPalette.redClr);
                }
              },
              label: 'Upload',
              screenHight: screenHeight),
        )
      ],
    );
  }
}
