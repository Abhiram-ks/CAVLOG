import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/Checkbox/checkbox_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckboxCubit(),
      child: BlocBuilder<CheckboxCubit, CheckboxState>(
        builder: (context, state) {
          bool isChecked = state is CheckboxChecked;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  context.read<CheckboxCubit>().toggleCheckbox();
                },
                checkColor: AppPalette.whiteClr,
                fillColor: WidgetStateProperty.all(
                  isChecked
                      ? Colors.green
                      : const Color.fromARGB(255, 209, 205, 205),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: "I Agree with all of your ",
                    style: TextStyle(
                      color: AppPalette.blackClr,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(
                          color: AppPalette.blueClr,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
