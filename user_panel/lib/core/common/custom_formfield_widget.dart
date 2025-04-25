import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/presentation/provider/cubit/icon_cubit/icon_cubit.dart';
import '../themes/colors.dart';
import '../utils/constant/constant.dart';

mixin FormFieldMixin {
  Widget buildTextFormField({
    required String label,
    required String hintText,
    required IconData prefixIcon,
    required BuildContext context,
    required TextEditingController controller,
    required String? Function(String?) validate,
    bool isfilterFiled = false,
    VoidCallback? fillterAction,
    bool isPasswordField = false,
    bool enabled = true,
    Color? borderClr,
    Color? fillClr,
    Color? suffixIconColor,
    ValueChanged<String>? onChanged,
    IconData? suffixIconData,
    VoidCallback? suffixIconAction,
  }) {
    return BlocProvider(
      create: (context) => IconCubit(),
      child: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 5),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppPalette.blackClr),
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
                  controller: controller,
                  autocorrect: true,
                  autofillHints: isPasswordField
                      ? [AutofillHints.password]
                      : [AutofillHints.username],
                  canRequestFocus: true,
                  validator: validate,
                  obscureText: isPasswordField ? !isVisible : false,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: enabled,
                  stylusHandwritingEnabled: true,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    filled: fillClr != null,
                    fillColor: fillClr,
                    hintText: hintText,
                    hintStyle: TextStyle(color: AppPalette.hintClr),
                    prefixIcon: Icon(
                      prefixIcon,
                      color: const Color.fromARGB(255, 52, 52, 52),
                    ),
                    suffixIcon: suffixIconData != null ||
                            isPasswordField ||
                            isfilterFiled
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (suffixIconData != null)
                                IconButton(
                                  icon: Icon(suffixIconData),
                                  color: suffixIconColor ?? AppPalette.greyClr,
                                  onPressed: suffixIconAction,
                                ),
                              if (isPasswordField)
                                IconButton(
                                  icon: Icon(isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color: AppPalette.blackClr,
                                  onPressed: () {
                                    context
                                        .read<IconCubit>()
                                        .togglePasswordVisibility(isVisible);
                                  },
                                ),
                              if (isfilterFiled)
                                IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.slider_horizontal_3),
                                  color: AppPalette.blackClr,
                                  onPressed: fillterAction,
                                ),
                            ],
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: borderClr ?? AppPalette.hintClr, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: borderClr ?? AppPalette.hintClr, width: 1),
                    ),
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
                    ),
                  ),
                );
              },
            ),
            ConstantWidgets.hight10(context),
          ],
        );
      }),
    );
  }
}
