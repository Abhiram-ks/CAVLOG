
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
    bool isPasswordField = false,
    bool enabled = true
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                  validator: validate,
                  obscureText: isPasswordField ? !isVisible : false,
                  style: const TextStyle(fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: enabled,
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
                      borderSide: BorderSide(color: AppPalette.hintClr, width: 1),
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