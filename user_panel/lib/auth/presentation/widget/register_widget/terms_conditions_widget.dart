import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../provider/cubit/checkbox_cubit/checkbox_cubit.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CheckboxCubit, CheckboxState>(
          builder: (context, state) {
            bool isCheked = state is CheckboxChecked;

            return Checkbox(
              value: isCheked,
              onChanged: (bool? value) {
                context.read<CheckboxCubit>().toggleCheckbox();
              },
              checkColor: AppPalette.whiteClr,
              fillColor: WidgetStateProperty.all(isCheked ? Colors.green : const Color.fromARGB(255, 209, 205, 205)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            );
          },
        ),
        RichText(
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
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
