import 'dart:developer';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/image_picker/image_picker_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/settings_widget/detail_edition_widget/pickimage_show_widget.dart';
import 'package:barber_pannel/core/common/action_button.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../core/common/custom_app_bar.dart';
import '../../../../../core/common/lottie_widget.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import '../../widgets/profile_widgets/settings_widget/detail_edition_widget/details_fileds_widget.dart' show ProfileEditDetailsFormsWidget;

class ProfileEditDetails extends StatelessWidget {
  final bool isShow;
  ProfileEditDetails({super.key, required this.isShow});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ventureNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectImagePath;
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;
      return ColoredBox(
        color: AppPalette.whiteClr,
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: BlocBuilder<FetchBarberBloc, FetchBarberState>(
            builder: (context, state) {
              if (state is FetchBarbeLoading) {
                return Center(
                    child: SpinKitFadingFour(
                  color: AppPalette.greyClr,
                  size: 23.0,
                ));
              }
              if (state is FetchBarberError) {
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottiefilesCommon(
                        assetPath: LottieImages.emptyData,
                        width: screenWidth * .4,
                        height: screenHeight * .4),
                    Text('${state.message}. Try Again'),
                  ],
                );
              }
              if (state is FetchBarberLoaded) {
                final barber = state.barber;
                _nameController.text = barber.barberName;
                _ventureNameController.text = barber.ventureName;
                _phoneController.text = barber.phoneNumber;
                _ageController.text = barber.age?.toString() ?? '';
                _addressController.text = barber.address;
                return SafeArea(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.077,
                        ),
                        child: Column(
                          children: [
                            BlocBuilder<ImagePickerBloc, ImagePickerState>(
                              builder: (context, state) {
                                if (state is ImagePickerSuccess) {
                                  selectImagePath = state.imagePath;
                                }return ProfileEditDetailsWidget(
                                  screenHeight: screenHeight,
                                  screenWidth: screenWidth,
                                  isShow: isShow,
                                  barber: barber,
                                );
                              },
                            ),
                            ProfileEditDetailsFormsWidget(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              isShow: isShow,
                              barber: barber,
                              formKey: _formKey,
                              nameController: _nameController,
                              addressController: _addressController,
                              ageController: _ageController,
                              phoneController: _phoneController,
                              ventureNameController: _ventureNameController,
                            ),
                            ConstantWidgets.hight50(context),
                            Text(isShow ? '' : 'Below is your unique ID'),
                            Text(
                              isShow ? '' : 'ID: ${barber.uid}',
                              style: TextStyle(
                                color: AppPalette.hintClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          floatingActionButton: isShow
              ? Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.09),
                  child: ActionButton(
                    screenWidth: screenWidth,
                    onTap: () {
                      log('Imagepicked: $selectImagePath');
                      if (_formKey.currentState!.validate()) {}
                    },
                    label: 'Save Changes',
                    screenHight: screenHeight,
                  ),
                )
              : SizedBox.shrink(),
        ),
      );
    });
  }
}

