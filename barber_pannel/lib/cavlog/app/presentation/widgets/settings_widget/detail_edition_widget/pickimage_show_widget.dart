
import 'dart:io';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/profile_helper_widget/profile_tabbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/image/app_images.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../../auth/data/models/barber_model.dart';
import '../../../provider/bloc/image_picker/image_picker_bloc.dart';

class ProfileEditDetailsWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final bool isShow;
  final BarberModel barber;
  const ProfileEditDetailsWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.isShow,
      required this.barber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isShow 
         ? "Refine your profile" 
         : 'Personal details',
          style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        ConstantWidgets.hight10(context),
        Text(isShow
            ? "Update your personal details to keep your profile fresh and up to date. A better profile means a better experience!"
            : "The informations to verify your identity and to keep our community safe"),
        ConstantWidgets.hight30(context),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                onTap: () {
                  if (isShow) {
                    context.read<ImagePickerBloc>().add(PickImageAction());
                  }
                },
                child: Container(
                    color: AppPalette.greyClr,
                    width: 60,
                    height: 60,
                    child: isShow ?  BlocBuilder<ImagePickerBloc, ImagePickerState>(
                      builder: (context, state) {
                        if (state is ImagePickerInitial) {
                          (barber.image != null && barber.image!.startsWith('http'))
                              ? Image.network(
                                  barber.image!,
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppPalette.buttonClr,
                                        value: loadingProgress.expectedTotalBytes !=null
                                            ? loadingProgress.cumulativeBytesLoaded /(loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.loginImageAbove,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppImages.loginImageAbove,
                                  fit: BoxFit.cover,
                                );
                        } else if (state is ImagePickerLoading) {
                          return SpinKitFadingFour(
                            color: AppPalette.whiteClr,
                            size: 23.0,
                          );
                        } else if (state is ImagePickerSuccess) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(state.imagePath),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (state is ImagePickerError) {
                          return Center(
                            child: Icon(
                              CupertinoIcons.photo_fill_on_rectangle_fill,
                              size: 35,
                              color: AppPalette.whiteClr,
                            ),
                          );
                        } return (barber.image != null &&  barber.image!.startsWith('http'))
                            ? Image.network(
                              barber.image!,
                                fit: BoxFit.contain,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppPalette.buttonClr,
                                      value:loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /(loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    AppImages.loginImageAbove,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                AppImages.loginImageAbove,
                                fit: BoxFit.cover,
                              );
                      },
                    ) : (barber.image != null && barber.image!.startsWith('http'))
                              ? Image.network(
                                  barber.image!,
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppPalette.buttonClr,
                                        value: loadingProgress.expectedTotalBytes !=null
                                            ? loadingProgress.cumulativeBytesLoaded /(loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.loginImageAbove,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppImages.loginImageAbove,
                                  fit: BoxFit.cover,
                                )
                )
              ),
            ),
            ConstantWidgets.width20(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileviewWidget(
                  screenWidth,
                  context,
                  Icons.verified,
                  barber.email,
                  textColor: AppPalette.greyClr,
                  AppPalette.blueClr,
                ),
              ],
            ),
          ],
        ),
        ConstantWidgets.hight20(context),
      ],
    );
  }
}