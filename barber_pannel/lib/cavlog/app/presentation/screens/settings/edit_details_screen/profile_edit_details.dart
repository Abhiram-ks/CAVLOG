import 'dart:developer';

import 'package:barber_pannel/cavlog/app/domain/usecases/update_user_profile.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/image_picker/image_picker_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/settings_widget/detail_edition_widget/pickimage_show_widget.dart';
import 'package:barber_pannel/core/cloudinary/cloudinary_service.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/common/common_loading_widget.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/common/custom_app_bar.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../data/repositories/image_picker_repo.dart';
import '../../../../domain/usecases/image_picker_usecase.dart';
import '../../../provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import '../../../provider/bloc/update_profile_bloc/update_profile_bloc.dart';
import '../../../widgets/settings_widget/detail_edition_widget/details_fileds_widget.dart'
    show ProfileEditDetailsFormsWidget;
import '../../../widgets/settings_widget/detail_edition_widget/profile_statehandle_widget.dart';

class ProfileEditDetails extends StatelessWidget {
  final bool isShow;
  ProfileEditDetails({super.key, required this.isShow});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ventureNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _imagePathClr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectImagePath;
    return BlocProvider(
      create: (context) => UpdateProfileBloc(
         CloudinaryService(), UpdateUserProfileUseCase()),
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return ColoredBox(
          color: AppPalette.scafoldClr ?? AppPalette.whiteClr,
          child: SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(),
              body: BlocBuilder<FetchBarberBloc, FetchBarberState>(
                builder: (context, state) {
                  if (state is FetchBarbeLoading || state is FetchBarberError) { LoadingScreen( screenHeight: screenHeight, screenWidth: screenWidth);
                  }
                  if (state is FetchBarberLoaded) {
                    final barber = state.barber;
                    _imagePathClr.text = barber.image ?? '';
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
                                BlocProvider(
                                  create: (context) => ImagePickerBloc(PickImageUseCase(ImagePickerRepositoryImpl( ImagePicker()))),
                                  child: BlocBuilder<ImagePickerBloc,
                                      ImagePickerState>(
                                    builder: (context, state) {
                                      if (state is ImagePickerSuccess) {
                                        selectImagePath = state.imagePath;
                                        log('Image Path: $selectImagePath');
                                      }
                                      return ProfileEditDetailsWidget(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        isShow: isShow,
                                        barber: barber,
                                      );
                                    },
                                  ),
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
                      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
                       listener: (context, state) {
                      handleProfileUpdateState(context, state);
                      },
                                                child: ActionButton(
                      screenWidth: screenWidth,
                      onTap: () {
                        selectImagePath ??= _imagePathClr.text;
                        context.read<UpdateProfileBloc>().add(
                            UpdateProfileRequest(
                                image: selectImagePath ?? _imagePathClr.text,
                                barberName: _nameController.text,
                                ventureName: _ventureNameController.text,
                                phoneNumber: _phoneController.text,
                                address: _addressController.text,
                                year: int.tryParse(_ageController.text) ??
                                    0));
                      },
                      label: 'Save Changes',
                      screenHight: screenHeight,
                       ),
                                              ),
                    )
                  : SizedBox.shrink(),
            ),
          ),
        );
      }),
    );
  }
}
