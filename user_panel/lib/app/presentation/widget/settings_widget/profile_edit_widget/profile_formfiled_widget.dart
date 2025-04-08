
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import 'package:user_panel/core/common/custom_phonefield_widget.dart';
import 'package:user_panel/core/routes/routes.dart';

import '../../../../../auth/presentation/widget/location_widget/location_textform_widget.dart';
import '../../../../../core/common/custom_formfield_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/validation/input_validation.dart';

class ProfileEditDetailsFormsWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final bool isShow;
  final UserModel user;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController addressController;
  const ProfileEditDetailsFormsWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.isShow,
      required this.user,
      required this.formKey,
      required this.nameController,
      required this.phoneController,
      required this.ageController,
      required this.addressController});

  @override
  State<ProfileEditDetailsFormsWidget> createState() =>
      _ProfileEditDetailsFormsWidgetState();
}

class _ProfileEditDetailsFormsWidgetState
    extends State<ProfileEditDetailsFormsWidget> with FormFieldMixin{
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registration Info',
                style: TextStyle(color: AppPalette.greyClr)),
            buildTextFormField(
              label: 'Full Name',
              hintText: 'Authorized Person Name',
              prefixIcon: CupertinoIcons.person_fill,
              controller: widget.nameController,
              validate: ValidatorHelper.validateName,
              enabled: widget.isShow,
              context: context,
            ),
            CustomPhonefieldWidget.phoneNumberField(
              label: "Phone Number",
              hintText: "Enter your number",
              prefixIcon: Icons.phone_android,
              controller: widget.phoneController,
              validator: ValidatorHelper.validatePhoneNumber,
              enabled: widget.isShow,
              iconColor: AppPalette.blueClr,
              context: context
            ),
            Text('Personal Info', style: TextStyle(color: AppPalette.greyClr)),
            LocationTextformWidget.locationAccessField(
              label: 'Address',
              hintText: "Select Address",
              prefixIcon: CupertinoIcons.location_solid,
              suffixIcon: CupertinoIcons.compass,
              controller: widget.addressController,
              validator: ValidatorHelper.validateLocation,
              prefixClr: AppPalette.redClr,
              suffixClr: AppPalette.hintClr,
              context: context,
              enabled: widget.isShow,
              action: () {
                Navigator.pushNamed(context, AppRoutes.locationAccess,
                    arguments: widget.addressController);
              }),
            buildTextFormField(
              label: 'Age',
              hintText: 'Your Answer',
              prefixIcon: CupertinoIcons.gift_fill,
              controller: widget.ageController,
              validate: ValidatorHelper.validateAge,
              enabled: widget.isShow,
              context: context,
            ),
          ],
        ));
  }
}
