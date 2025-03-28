import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/icon/icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../themes/colors.dart';
import '../utils/media_quary/constant/constant.dart';

class TextfiledPhone extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextfiledPhone({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
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
            Color suffixColor = state?.color ?? AppPalette.hintClr;

            return TextFormField(
              controller: controller,
              validator: validator,
              obscureText: false,
              style: const TextStyle(fontSize: 16),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType:  TextInputType.number,
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
                  color: AppPalette.blackClr,
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
