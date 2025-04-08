import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';

class LocationTextformWidget {
  static Widget locationAccessField({
    required String label,
    required String hintText,
    required IconData prefixIcon,
    required IconData suffixIcon,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required Color prefixClr,
    required Color suffixClr,
    required VoidCallback action,
    required BuildContext context,
    bool enabled = true
  }){
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
                 TextFormField(
              controller: controller,
              validator: validator,
              obscureText: false,
              style: const TextStyle(fontSize: 16),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              enabled: enabled,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppPalette.hintClr),
                prefixIcon: InkWell(
                  onTap:  action,
                  child: Icon(
                    prefixIcon,
                    color: prefixClr,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap:  action,
                  child: Icon(
                    suffixIcon,
                    color: suffixClr,
                  ),
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
            ),
        ConstantWidgets.hight10(context),
      ],
    );
  }
}