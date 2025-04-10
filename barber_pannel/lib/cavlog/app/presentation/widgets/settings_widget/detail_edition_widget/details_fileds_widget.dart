import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/common/phone_textfield.dart';
import '../../../../../../core/common/textfield_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/validation/input_validations.dart';
import '../../../../data/models/barber_model.dart';

class ProfileEditDetailsFormsWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final bool isShow;
  final BarberModel barber;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController ventureNameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController addressController;
  const ProfileEditDetailsFormsWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.isShow,
      required this.barber,
      required this.formKey,
      required this.nameController,
      required this.ventureNameController,
      required this.phoneController,
      required this.ageController,
      required this.addressController});

  @override
  State<ProfileEditDetailsFormsWidget> createState() =>
      _ProfileEditDetailsFormsWidgetState();
}

class _ProfileEditDetailsFormsWidgetState
    extends State<ProfileEditDetailsFormsWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registration Info',
                style: TextStyle(color: AppPalette.hintClr)),
            TextFormFieldWidget(
              label: 'Full Name',
              hintText: 'Authorized Person Name',
              prefixIcon: CupertinoIcons.person_fill,
              controller: widget.nameController,
              validate: ValidatorHelper.validateName,
              enabled: widget.isShow,
            ),
            TextFormFieldWidget(
              label: 'Venture name',
              hintText: 'Registered Venture Name',
              prefixIcon: Icons.add_business,
              controller: widget.ventureNameController,
              validate: ValidatorHelper.validateText,
              enabled: widget.isShow,
            ),
            TextfiledPhone(
              label: "Phone Number",
              hintText: "Enter your number",
              prefixIcon: Icons.phone_android,
              controller: widget.phoneController,
              validator: ValidatorHelper.validatePhoneNumber,
              enabled: widget.isShow,
              iconColor: AppPalette.blueClr,
            ),
            Text('Personal Info', style: TextStyle(color: AppPalette.hintClr)),
            TextFormFieldWidget(
              label: 'Owner Age',
              hintText: 'Your Answer',
              prefixIcon: CupertinoIcons.gift_fill,
              controller: widget.ageController,
              validate: ValidatorHelper.validateAge,
              enabled: widget.isShow,
            ),
            TextFormFieldWidget(
              label: 'Owner Address',
              hintText: 'Your Answer',
              prefixIcon: CupertinoIcons.location_solid,
              controller: widget.addressController,
              validate: ValidatorHelper.validateText,
              enabled: widget.isShow,
            ),
          ],
        ));
  }
}
