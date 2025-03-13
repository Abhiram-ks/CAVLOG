import 'package:barber_pannel/core/common/snackbar_common.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/presentation/provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/action_button_common.dart';
import '../../../core/common/textfiled_common.dart';
import '../../../core/common/textfiled_phone_common.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/constant/constant.dart';
import '../../../core/validation/validation.dart';

class DetilsFormField extends StatefulWidget {
  const DetilsFormField({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.formKey,
  });

  final double screenWidth;
  final double screenHight;
  final GlobalKey<FormState> formKey;

  @override
  State<DetilsFormField> createState() => _DetilsFormFieldState();
}

class _DetilsFormFieldState extends State<DetilsFormField> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ventureNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: 'Full Name',
            hintText: 'Authorized Person Name',
            prefixIcon: CupertinoIcons.person_fill,
            controller: nameController,
            validate: ValidatorHelper.validateName,
          ),
          TextFormFieldWidget(
            label: 'Venture name',
            hintText: 'Registered Venture Name',
            prefixIcon: CupertinoIcons.building_2_fill,
            controller: ventureNameController,
            validate: ValidatorHelper.validateText,
          ),
          TextfiledPhone(
            label: "Phone Number",
            hintText: "Enter your number",
            prefixIcon: Icons.phone_android,
            controller: phoneController,
            validator: ValidatorHelper.validatePhoneNumber,
          ),
          TextFormFieldWidget(
            label: 'Owner Address',
            hintText: 'Your Answer',
            prefixIcon: CupertinoIcons.location_solid,
            controller: addressController,
            validate: ValidatorHelper.validateText,
          ),
          ConstantWidgets.hight30(context),
          BlocSelector<RegisterSubmitionBloc,RegisterSubmitionState, bool>(
           selector: (state) => state is RegisterSuccess,
                builder: (context, state) {
                  return ActionButton(
                      screenWidth: widget.screenWidth,
                      onTap: () {
                        if (widget.formKey.currentState!.validate()) {
                          context.read<RegisterSubmitionBloc>().add(
                              UpdatePersonalDetails(
                                  fullName: nameController.text,
                                  ventureName: ventureNameController.text,
                                  phoneNumber: phoneController.text,
                                  address: addressController.text));
                          
                          Navigator.pushNamed(
                              context, AppRoutes.registerCredentials);
                        } else {
                          CustomeSnackBar.show(context: context, title: 'Submission Failed', description: 'Please fill in all the required fields before proceeding.', iconColor: AppPalette.redClr, icon: CupertinoIcons.clear_circled);
                        }
                      },
                      label: 'Next',
                      screenHight: widget.screenHight);
                },
          
          ),
        ],
      ),
    );
  }
}
