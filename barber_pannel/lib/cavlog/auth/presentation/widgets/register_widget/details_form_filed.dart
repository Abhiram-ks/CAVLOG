import 'package:barber_pannel/core/common/snackbar_helper.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/action_button.dart';
import '../../../../../core/common/textfield_helper.dart';
import '../../../../../core/common/phone_textfield.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/validation/input_validations.dart';
import '../../provider/cubit/buttonProgress/button_progress_cubit.dart';

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
            prefixIcon: Icons.add_business,
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
          BlocSelector<RegisterSubmitionBloc, RegisterSubmitionState, bool>(
            selector: (state) => state is RegisterSuccess,
            builder: (context, state) {
              return ActionButton(
                  screenWidth: widget.screenWidth,
                  onTap: () async{
                    final buttonCubit = context.read<ButtonProgressCubit>();
                    final registerBloc = context.read<RegisterSubmitionBloc>();
                    final navigator = Navigator.of(context);

                    if (widget.formKey.currentState!.validate()) {
                      buttonCubit.startLoading();
                      registerBloc.add(UpdatePersonalDetails( fullName: nameController.text,
                              ventureName: ventureNameController.text,
                              phoneNumber: phoneController.text,
                              address: addressController.text));
                      await Future.delayed(const Duration(milliseconds: 40));
                      if (mounted) {
                       navigator.pushNamed(AppRoutes.registerCredentials);
                      }
                      buttonCubit.stopLoading();
                    } else {
                      CustomeSnackBar.show(
                          context: context,
                          title: 'Submission Failed',
                          description:'Please fill in all the required fields before proceeding.',
                          iconColor: AppPalette.redClr,icon: CupertinoIcons.clear_circled);
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
