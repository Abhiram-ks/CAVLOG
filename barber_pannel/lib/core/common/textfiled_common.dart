import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  const TextFormFieldWidget({
    super.key, required this.label, required this.hintText, required this.prefixIcon,
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        TextFormField(
          obscureText: false,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppPalette.hintClr),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppPalette.hintClr, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppPalette.hintClr, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppPalette.redClr,
                width: 1,
              ),
            ),
          ),
        ),
        ConstantWidgets.hight10(context),
      ],
    );
  }
}
