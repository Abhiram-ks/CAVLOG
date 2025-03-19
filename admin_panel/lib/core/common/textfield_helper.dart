import 'package:admin/presentation/provider/cubit/Icon/icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../themes/colors.dart';
import '../utils/media_quary/constant/constant.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String? value) validate;

  const TextFormFieldWidget(
      {super.key,
      required this.label,
      required this.hintText,
      required this.prefixIcon,
      this.isPasswordField = false, required this.controller,required this.validate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 5),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        BlocSelector<IconCubit, IconState, bool>(
          selector: (state) {
            if (state is PasswordVisibilityUpdated) {
              return state.isVisible; 
            }
            return false;
          },
          builder: (context, isVisible) {
            return TextFormField(
              controller:  controller,
              validator:  validate,
              obscureText: isPasswordField ? !isVisible : false,
              style: const TextStyle(fontSize: 16),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppPalette.hintClr),
                prefixIcon: Icon(
                  prefixIcon,
                  color: const Color.fromARGB(255, 52, 52, 52),
                ),
                suffixIcon: isPasswordField
                    ? GestureDetector(
                        onTap: () {
                          context.read<IconCubit>().togglePasswordVisibility(isVisible);
                        },
                        child: Icon(
                             isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppPalette.hintClr, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppPalette.hintClr, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppPalette.redClr,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppPalette.redClr,
                    width: 1,
                  ),
                )
              ),
            );
          },
        ),
        ConstantWidgets.hight10(context),
      ],
    );
  }
}
