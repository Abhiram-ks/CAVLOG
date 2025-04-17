import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'package:user_panel/auth/presentation/widget/location_widget/location_textform_widget.dart';
import 'package:user_panel/core/common/custom_actionbutton_widget.dart';
import 'package:user_panel/core/common/custom_formfield_widget.dart';
import 'package:user_panel/core/common/custom_phonefield_widget.dart';
import 'package:user_panel/core/common/custom_snackbar_widget.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/themes/colors.dart';
import 'package:user_panel/core/utils/constant/constant.dart';
import '../../../../core/validation/input_validation.dart';

class RegisterDetailsFormWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;

  const RegisterDetailsFormWidget(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.formKey});

  @override
  State<RegisterDetailsFormWidget> createState() =>
      _RegisterDetailsFormWidgetState();
}

class _RegisterDetailsFormWidgetState extends State<RegisterDetailsFormWidget>
    with FormFieldMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          buildTextFormField(
              label: 'Full name',
              hintText: 'Your Answer',
              prefixIcon: CupertinoIcons.person_fill,
              context: context,
              controller: _nameController,
              validate: ValidatorHelper.validateName),
          CustomPhonefieldWidget.phoneNumberField(
              label: "Phone number",
              hintText: "Enter phone number",
              prefixIcon: Icons.phone_android,
              context: context,
              controller: _phoneController,
              validator: ValidatorHelper.validatePhoneNumber),
          LocationTextformWidget.locationAccessField(
              label: 'Address',
              hintText: "Select Address",
              prefixIcon: CupertinoIcons.location_solid,
              suffixIcon: CupertinoIcons.compass,
              controller: _addressController,
              validator: ValidatorHelper.validateLocation,
              prefixClr: AppPalette.redClr,
              suffixClr: AppPalette.hintClr,
              context: context,
              action: () {
                Navigator.pushNamed(context, AppRoutes.locationAccess,
                    arguments: _addressController);
              }),
          ConstantWidgets.hight50(context),
          BlocSelector<RegisterBloc, RegisterState, bool>(
            selector: (state) => state is RegisterSuccess,
            builder: (context, state) {
              return ButtonComponents.actionButton(
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  label: 'Next',
                  onTap: () async{
                    final buttonCubit = context.read<ButtonProgressCubit>();
                    final registerBloc = context.read<RegisterBloc>();
                    final navigator = Navigator.of(context);


                    if (widget.formKey.currentState!.validate()) {
                      buttonCubit.startLoading();
                      registerBloc.add(RegisterPersonalData(fullName: _nameController.text.trim(), phoneNumber: _phoneController.text, address: _addressController.text.trim()));
                      await Future.delayed(const Duration(milliseconds: 20));
                      if (mounted){ navigator.pushNamed(AppRoutes.registerCredential);}
                      buttonCubit.stopLoading();
                    } else {
                      CustomeSnackBar.show(
                        context: context,
                          title: 'Submission Failed',
                          description:'Please fill in all the required fields before proceeding.',
                          titleClr: AppPalette.redClr,);
                    }

                  });
            },
          )
        ],
      ),
    );
  }
}
