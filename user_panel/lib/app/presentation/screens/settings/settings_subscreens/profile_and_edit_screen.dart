import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_panel/app/domain/usecases/image_picker_usecase.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetching_bloc/fetch_user_bloc/fetch_user_bloc.dart';
import 'package:user_panel/app/presentation/widget/settings_widget/profile_edit_widget/profile_statehandle_widget.dart';
import 'package:user_panel/core/common/custom_actionbutton_widget.dart';
import '../../../../../core/common/custom_appbar_widget.dart';
import '../../../../../core/common/custom_loadingscreen_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../../data/repositories/image_picker_repo.dart';
import '../../../provider/bloc/image_picker/imge_picker_bloc.dart';
import '../../../provider/bloc/updateprofile_bloc/update_profile_bloc.dart';
import '../../../widget/settings_widget/profile_edit_widget/imagepic_show_widget.dart';
import '../../../widget/settings_widget/profile_edit_widget/profile_formfiled_widget.dart';

class ProfileEditDetails extends StatelessWidget {
  final bool isShow;
  ProfileEditDetails({super.key, required this.isShow});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _imagePathClr = TextEditingController();
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
          body: BlocBuilder<FetchUserBloc, FetchUserState>(
            builder: (context, state) {
              if (state is FetchUserLoading) {
                return LoadingScreen( screenHeight: screenHeight, screenWidth: screenWidth);
              }
              if (state is FetchUserError) {
                LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth);
              }
              if (state is FetchUserLoaded) {
                final user = state.user;
                _imagePathClr.text = user.image;
                _nameController.text = user.userName;
                _phoneController.text = user.phoneNumber;
                _ageController.text = user.age.toString();
                _addressController.text = user.address;
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
                              create: (context) => ImagePickerBloc(
                                  PickImageUseCase(ImagePickerRepositoryImpl(
                                      ImagePicker()))),
                              child: BlocBuilder<ImagePickerBloc,
                                  ImagePickerState>(
                                builder: (context, state) {
                                  if (state is ImagePickerSuccess) {
                                    selectImagePath = state.imagePath;
                                  }
                                  return ProfileEditDetailsWidget(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    isShow: isShow,
                                    user: user,
                                  );
                                },
                              ),
                            ),
                            ProfileEditDetailsFormsWidget(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              isShow: isShow,
                              user: user,
                              formKey: _formKey,
                              nameController: _nameController,
                              addressController: _addressController,
                              ageController: _ageController,
                              phoneController: _phoneController,
                            ),
                            ConstantWidgets.hight50(context),
                            user.google
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                          AppImages.googleImage,
                                          height: screenHeight * 0.056,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text('Google-linked account'),
                                    ],
                                  )
                                : Text(''),
                            Text(
                              isShow ? '' : 'Below is your unique ID',
                              style: TextStyle(color: AppPalette.greyClr),
                            ),
                            Text(
                              isShow ? '' : 'ID: ${user.uid}',
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
                    child: ButtonComponents.actionButton(
                      screenWidth: screenWidth,
                      onTap: () {
                        selectImagePath ??= _imagePathClr.text;
                        context.read<UpdateProfileBloc>().add(
                            UpdateProfileRequest(
                                image: selectImagePath ?? '',
                                userName: _nameController.text,
                                phoneNumber: _phoneController.text,
                                address: _addressController.text,
                                age: int.tryParse(_ageController.text) ?? 0));
                      },
                      label: 'Save Changes',
                      screenHeight: screenHeight,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      );
    });
  }
}
