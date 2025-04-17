
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/common/textfield_helper.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../../../core/validation/input_validations.dart';
import '../../../provider/cubit/edit_mode/edit_mode_cubit.dart';

class ServiceManagementFiled extends StatefulWidget {
  const ServiceManagementFiled(
      {super.key,
      required this.context,
      required this.screenWidth,
      required this.label,
      required this.serviceRate,
      required this.deleteAction,
       required this.updateAction});

  final BuildContext context;
  final double screenWidth;
  final String label;
  final String serviceRate;
  final VoidCallback deleteAction;
  final void Function(double value) updateAction; 
  @override
  State<ServiceManagementFiled> createState() => _ServiceManagementFiledState();
}

class _ServiceManagementFiledState extends State<ServiceManagementFiled> {
  late final TextEditingController serviceRateController;

  @override
  void initState() {
    super.initState();
    serviceRateController = TextEditingController(text: widget.serviceRate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<EditModeCubit, bool>(
            builder: (context, isEditable) {
              return TextFormFieldWidget(
                enabled: isEditable,
                label: widget.label,
                hintText: 'Enter your charge',
                prefixIcon: Icons.currency_rupee,
                controller: serviceRateController,
                validate: ValidatorHelper.validateAmount,
              );
            },
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: widget.screenWidth * 0.12,
          width: widget.screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.greyClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.orengeClr,
            focusColor: AppPalette.greenClr,
            onPressed:(){
               final value = double.tryParse(serviceRateController.text.trim());
               if(value != null){
                widget.updateAction(value);
               }
            },
            icon: Icon(
              CupertinoIcons.floppy_disk,
              color: AppPalette.whiteClr,
            ),
          ),
        ),
        ConstantWidgets.width10(context),
        Container(
          height: widget.screenWidth * 0.12,
          width: widget.screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppPalette.redClr,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            splashColor: Colors.white,
            highlightColor: AppPalette.redClr,
            focusColor: AppPalette.greenClr,
            onPressed: widget.deleteAction,
            icon: Icon(
              CupertinoIcons.delete_solid,
              color: AppPalette.whiteClr,
            ),
          ),
        ),
      ],
    );
  }
}
