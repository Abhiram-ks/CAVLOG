import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/core/themes/colors.dart';

import '../../auth/presentation/provider/cubit/icon_cubit/icon_cubit.dart';
import '../utils/constant/constant.dart';

class CustomPhonefieldWidget {
  static Widget phoneNumberField({
    required String label,
    required String hintText,
    required IconData prefixIcon,
    required BuildContext context,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    Color iconColor = AppPalette.hintClr,
    bool enabled = true
  }) {
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
        BlocSelector<IconCubit, IconState, ColorUpdated?>(
          selector: (state) {
            if (state is ColorUpdated) {
              return state;
            }
            return null;
          },
          builder: (context, state) {
            Color suffixColor = state?.color ?? iconColor;

            return TextFormField(
              controller: controller,
              validator: validator,
              obscureText: false,
              style: const TextStyle(fontSize: 16),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType:  TextInputType.number,
              enabled: enabled,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
              context.read<IconCubit>().updateIcon(
                      value.length == 10,
              );
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppPalette.hintClr),
                prefixIcon: Icon(
                  prefixIcon,
                  color:  const Color.fromARGB(255, 52, 52, 52),
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: suffixColor,
                ),
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