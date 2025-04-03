import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/themes/colors.dart';

class Opttextformfiled extends StatelessWidget {
  final TextEditingController controller;
  final double screenWidth;
  final double screenHight;
  final Function(String) onChanged;

  const Opttextformfiled(
      {super.key, required this.screenWidth, required this.screenHight, required this.controller, required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return _sizedbox(context,controller,screenHight,screenWidth);
  }


  SizedBox _sizedbox(BuildContext context, TextEditingController controller,double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHight * 0.07, 
      width: screenWidth * 0.12,
        child: TextFormField(
          onChanged: (value) {
            if (value.isNotEmpty) {
               FocusScope.of(context).nextFocus();
            }else{
              FocusScope.of(context).previousFocus(); 
            }
            onChanged(value);
           
          },
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          style: const TextStyle(fontSize: 22),
           textAlign: TextAlign.center,
           keyboardType:  TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppPalette.hintClr, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppPalette.orengeClr, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppPalette.redClr,
                width: 1,
              ),
            ),
          ),
        ),
      );
  }
}
